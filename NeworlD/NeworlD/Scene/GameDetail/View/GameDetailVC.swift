//
//  GameDetailVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 9.12.2022.
//

import UIKit

class GameDetailVC: UIViewController {

    @IBOutlet private weak var name: UILabel!
    
    var model: GameModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = "Detail"
    }
   
}
