//
//  NetworkManager.swift
//  CertificateGrabber
//
//  Created by Alaa on 02/04/2024.
//

import Foundation

class NetworkManager {

    enum ManagerErrors: Error {
        case invalidResponse
        case invalidStatusCode(Int)
    }

    enum HttpMethod: String {
        case get
        case post

        var method: String { rawValue.uppercased() }
    }


   private let networkDelegate = NetworkManagerDelegate()

    func request<T: Decodable>(fromURL url: URL, httpMethod: HttpMethod = .get, completion: @escaping (Result<T, Error>) -> Void) {

        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        

        let urlSession = URLSession(configuration: .default, delegate: networkDelegate, delegateQueue: nil).dataTask(with: request) { data, response, error in
        
            if let error = error {
                completionOnMain(.failure(error))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }

            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(users))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }
        urlSession.resume()
    }
}


class NetworkManagerDelegate: NSObject, URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                if let serverTrust = challenge.protectionSpace.serverTrust {
                    // Retrieve the server's certificate
    
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                        let serverCertificateData = SecCertificateCopyData(serverCertificate)
                        // Convert the certificate to data format
                        let serverCertificateString = serverCertificateData as Data
                        print(serverCertificateData, "🙌")
                    }
                }
            }
            
            completionHandler(.performDefaultHandling, nil)
    }
    
    
}
