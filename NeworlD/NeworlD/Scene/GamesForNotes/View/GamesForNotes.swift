//
//  GamesForNotes.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 12.12.2022.
//

import UIKit

class GamesForNotes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var searchTableView: UITableView!
    private var viewModel = GamesForNotesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getSearchGamesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
}
