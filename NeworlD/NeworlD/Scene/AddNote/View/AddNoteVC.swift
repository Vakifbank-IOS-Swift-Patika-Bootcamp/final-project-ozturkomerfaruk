//
//  AddNoteVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 12.12.2022.
//

import UIKit

protocol AddNoteVCDelegate: AnyObject {
    func saveCoreData(title: String, body: String, gameId: Int)
    func updateCoreData(title: String, body: String, gameId: Int, model: GameNoteEntity)
}

class AddNoteVC: UIViewController {
    
    weak var delegate: AddNoteVCDelegate?
    var game: GameModel? //GameId çekmek için
    var gameNote: GameNoteEntity?
    
    @IBOutlet private weak var saveOutlet: UIButton!
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextView: UITextView!
    @IBOutlet private weak var gameButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.layer.cornerRadius = 15
        bodyTextView.layer.cornerRadius = 15
        
        if gameNote != nil {
            titleTextField.text = gameNote?.title
            bodyTextView.text = gameNote?.body
            saveOutlet.setTitle("Update", for: .normal)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if gameNote != nil {
            delegate?.updateCoreData(title: titleTextField.text!, body: bodyTextView.text!, gameId: 1, model: gameNote!)
        } else {
            delegate?.saveCoreData(title: titleTextField.text!, body: bodyTextView.text, gameId: 1)
        }
        
        dismiss(animated: true)
    }
    
    @IBAction func gameButtonAction(_ sender: Any) {
        print((gameButtonOutlet.titleLabel?.text!)!)
    }
    
}
