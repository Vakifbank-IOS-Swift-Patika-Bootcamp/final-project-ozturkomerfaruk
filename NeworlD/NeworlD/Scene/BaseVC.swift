//
//  BaseVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 14.12.2022.
//

import UIKit
import SwiftAlertView

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if Constants.API_KEY == "##API_KEY##" {
            showAlert(title: "Create an API Key!", message: "The application will be closed because you do not have the API Key. Please create a Key.", completion: { exit(0) })
        }
    }
    
    func showAlert(title: String, message: String, completion: @escaping () -> Void) {
        SwiftAlertView.show(title: title, message: message, buttonTitles: ["Ok"]).onButtonClicked {
            _, _ in
            completion()
        }
    }
    
    func showAlertWithCancel(title: String, message: String, completion: @escaping ( _ buttonIndex: Int) -> Void) {
        SwiftAlertView.show(title: title, message: message, buttonTitles: ["Ok", "Cancel"]).onButtonClicked {
            _, buttonIndex in
            completion(buttonIndex)
        }
    }
}
