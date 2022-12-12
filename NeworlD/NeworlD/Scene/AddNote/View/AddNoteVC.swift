//
//  AddNoteVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 12.12.2022.
//

import UIKit

protocol AddNoteVCDelegate: AnyObject {
    func closeAddNoteVC()
}

class AddNoteVC: UIViewController {
    
    weak var delegate: AddNoteVCDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        print("Save Action")
    }
    
}
