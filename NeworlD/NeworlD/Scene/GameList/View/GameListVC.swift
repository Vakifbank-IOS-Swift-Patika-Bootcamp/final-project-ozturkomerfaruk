//
//  ViewController.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import UIKit

class GameListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.getGameList(page: 1, pageSize: 1) { games, error in
            for i in games!.first!.parentPlatforms {
                print(i.platform.name)
            }
        }
    }

}

