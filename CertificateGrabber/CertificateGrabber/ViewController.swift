//
//  ViewController.swift
//  CertificateGrabber
//
//  Created by Alaa on 02/04/2024.
//

import UIKit

class ViewController: UIViewController {

    let networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        guard let url = URL(string: "https://iis01.exas2030.com/qPMO_EmpV2.0.04/api/Dashboard/v1/AssestData/OTPPageAndCaptcha_Status_APP?culture=en-sa") else { fatalError("Invalid URL") }
        
     
        networkManager.request(fromURL: url) { (result: Result<Settinga, Error>) in
            switch result {
            case .success(let settinga):
                debugPrint("We got a successful result with \(settinga) settinga.")
            case .failure(let error):
                debugPrint("We got a failure trying to get the Data. The error: \(error.localizedDescription)")
            }
         }

        
    }
    
    @IBAction func saveCertificateTapped(_ sender: Any) {
        shareCertificate()
    }
    
    func shareCertificate() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
           let filePath = documentsPath.appendingPathComponent("serverCertificate.cer")
           
           let activityViewController = UIActivityViewController(activityItems: [filePath], applicationActivities: nil)
           
           if let popoverController = activityViewController.popoverPresentationController {
               popoverController.sourceView = self.view
               popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
               popoverController.permittedArrowDirections = []
           }
           
           present(activityViewController, animated: true, completion: nil)
       }


}

