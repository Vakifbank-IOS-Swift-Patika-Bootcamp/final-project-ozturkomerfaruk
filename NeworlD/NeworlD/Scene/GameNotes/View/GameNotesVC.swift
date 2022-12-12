//
//  GameNotesVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 11.12.2022.
//

import UIKit

class GameNotesVC: UIViewController {
    
    private var viewModel = GameListViewModel()
    
    @IBOutlet private weak var addNoteOutlet: UIButton!
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNoteOutlet.layer.cornerRadius = addNoteOutlet.frame.height / 2
        notesTableView.backgroundColor = .purple
        
        configureTableView()
    }
    
    private func configureTableView() {
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }

    @IBAction func addNoteAction(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addNoteVC") as? AddNoteVC else { return }
        present(vc, animated: true, completion: nil)
    }
    

}

extension GameNotesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getGameListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
