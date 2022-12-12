//
//  GameNotesVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 11.12.2022.
//

import UIKit

class GameNotesVC: UIViewController {
    
    private var viewModel = GameNotesViewModel()
    
    @IBOutlet private weak var addNoteOutlet: UIButton!
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self

        addNoteOutlet.layer.cornerRadius = addNoteOutlet.frame.height / 2
        notesTableView.backgroundColor = .purple
        
        viewModel.fetchGameNotes()
        configureTableView()
    }
    
    private func configureTableView() {
        notesTableView.delegate = self
        notesTableView.dataSource = self
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
        
    }
}

//Mantıken buranın viewmodel üzerinde gerçekleşmesi lazım.
extension GameNotesVC: AddNoteVCDelegate {
    func saveCoreData(title: String, body: String, gameId: Int) {
        viewModel.appendGameNote(title: title, body: body, gameId: gameId)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getGameNotes(index: indexPath.row).title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.deleteGameNote(index: indexPath.row)
        return tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.getGameNotes(index: indexPath.row))
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addNoteVC") as? AddNoteVC else { return }
        vc.delegate = self
        vc.gameNote = viewModel.getGameNotes(index: indexPath.row)
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
}
