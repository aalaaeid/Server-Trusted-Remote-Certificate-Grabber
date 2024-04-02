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


}

