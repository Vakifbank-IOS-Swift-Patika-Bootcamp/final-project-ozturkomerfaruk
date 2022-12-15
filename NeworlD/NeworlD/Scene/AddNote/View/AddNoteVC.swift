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

final class AddNoteVC: BaseVC {
    
    weak var delegate: AddNoteVCDelegate?
    var gameNote: GameNoteEntity?
    var gameId: Int?
    
    @IBOutlet private weak var saveOutlet: UIButton!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var bodyTextView: UITextView!
    @IBOutlet private weak var cancelButtonOutlet: UIButton!
    @IBOutlet private weak var gameSearchNameTextField: UITextField!
    @IBOutlet private weak var gameNameLabel: UILabel!

    private var viewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAddNoteVC()
    }
    
    func configureAddNoteVC() {
        titleTextField.layer.cornerRadius = titleTextField.frame.height / 3
        bodyTextView.layer.cornerRadius = 20
        saveOutlet.layer.cornerRadius = saveOutlet.frame.height / 3
        bodyTextView.textContainerInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        titleTextField.changeColorPlaceholder(tf: titleTextField, string: "...", color: .lightText)
        titleTextField.changeColorPlaceholder(tf: gameSearchNameTextField, string: "type..", color: .lightText)
        
        if gameNote != nil {
            titleTextField.text = gameNote?.title
            bodyTextView.text = gameNote?.body
            viewModel.fetchGamesWithId(id: Int(gameNote!.gameId))
            saveOutlet.setTitle("Update", for: .normal)
        }
        
        viewModel.delegate = self
    }

    @IBAction func cancelAction(_ sender: Any) {
        showAlertWithCancel(title: "Warning!", message: "It will be canceled") { [weak self] buttonIndex in
            guard let self = self else { return }
            if buttonIndex == 0 {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if gameId == nil || titleTextField.text!.isEmpty || bodyTextView.text!.isEmpty {
            showAlert(title: "Warning!", message: "Please complete all required fields!", completion: { })
        } else {
            if gameNote != nil {
                delegate?.updateCoreData(title: titleTextField.text!, body: bodyTextView.text!, gameId: gameId ?? -1, model: gameNote!)
                dismiss(animated: true)
            } else {
                delegate?.saveCoreData(title: titleTextField.text!, body: bodyTextView.text, gameId: gameId ?? -1)
                dismiss(animated: true)
            }
        }      
    }
    
    
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "gamesForNotes") as? GamesForNotesVC else { return }
        vc.searchGame = gameSearchNameTextField.text
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension AddNoteVC: AddNoteViewModelDelegate {
    func gamesLoaded() {
        gameNameLabel.text = viewModel.getGameWithId()?.name ?? ""
    }
    
    func gamesFailed(error: Error) {
        showAlert(title: "Error!", message: "\(error)", completion: { })
    }
    
    func preFetch() {
        indicator.startAnimating()
    }
    
    func postFetch() {
        indicator.stopAnimating()
    }
}

extension AddNoteVC: GamesForNotesDelegate {
    func gameNameFunc(name: String, id: Int) {
        gameNameLabel.text = name
        gameId = id
    }
}
