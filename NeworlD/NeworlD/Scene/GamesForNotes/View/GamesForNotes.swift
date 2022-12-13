//
//  GamesForNotes.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 12.12.2022.
//

import UIKit

protocol GamesForNotesDelegate: AnyObject {
    func gameNameFunc(name: String, id: Int)
}

final class GamesForNotes: UIViewController, UITableViewDelegate, UITableViewDataSource, GamesForNotesViewModelDelegate {
    
    weak var delegate: GamesForNotesDelegate?
    
    func gamesLoaded() {
        searchTableView.reloadData()
    }
    
    func gamesFailed(error: Error) {
        print("Error!")
    }
    
    
    @IBOutlet private weak var searchTableView: UITableView!
    private var viewModel = GamesForNotesViewModel()
    var searchGame: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        viewModel.delegate = self
        viewModel.fetchSearchGames(searchGameName: searchGame ?? "")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getSearchGamesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gamesForNotesCustomCell", for: indexPath) as? GamesForNotesCustomCell,
              let model = viewModel.getSearchGame(at: indexPath.row) else { return UITableViewCell() }
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.getSearchGame(at: indexPath.row)
        delegate?.gameNameFunc(name: model!.name, id: model!.id)
        dismiss(animated: true)    }
}
