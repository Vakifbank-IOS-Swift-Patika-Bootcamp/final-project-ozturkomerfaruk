//
//  GameNotesVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 11.12.2022.
//

import UIKit

final class GameNotesVC: BaseVC {
    
    private var viewModel = GameNotesViewModel()
    
    @IBOutlet private weak var addNoteOutlet: UIButton!
    @IBOutlet private weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        viewModel.fetchGameNotes()
        notesTableView.delegate = self
        notesTableView.dataSource = self
        viewModel.delegate = self
        
        addNoteOutlet.layer.cornerRadius = addNoteOutlet.frame.height / 2
        notesTableView.backgroundColor = .clear
    }

    @IBAction func addNoteAction(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addNoteVC") as? AddNoteVC else { return }
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension GameNotesVC: GameNotesViewModelDelegate {
    func notesLoaded() {
        notesTableView.reloadData()
    }
    
    func notesFailed(error: Error) {
        showAlert(title: "Error", message: "\(error)", completion: { })
    }
}

extension GameNotesVC: AddNoteVCDelegate {
    func saveCoreData(title: String, body: String, gameId: Int) {
        showAlert(title: "Successful!", message: "\(title) \n message saved successfuly") { [weak self] in
            guard let self = self else { return }
            self.viewModel.appendGameNote(title: title, body: body, gameId: gameId)
        }
    }
    
    func updateCoreData(title: String, body: String, gameId: Int, model: GameNoteEntity) {
        viewModel.updateGameNote(title: title, body: body, gameId: gameId, model: model)
    }
}

extension GameNotesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGameNotesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gameNotesCustomCell", for: indexPath) as? GameNotesCustomCell,
              let titleString = viewModel.getGameNotes(index: indexPath.row).title else { return UITableViewCell() }
        cell.configure(titleString: titleString)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        showAlertWithCancel(title: "Warning!", message: "Do you really want to delete?") { [weak self] buttonIndex in
            guard let self = self else { return }
            if buttonIndex == 0 {
                self.viewModel.deleteGameNote(index: indexPath.row)
                return tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.getGameNotes(index: indexPath.row))
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addNoteVC") as? AddNoteVC else { return }
        vc.delegate = self
        vc.gameNote = viewModel.getGameNotes(index: indexPath.row)
        vc.gameId = Int(viewModel.getGameNotes(index: indexPath.row).gameId)
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
