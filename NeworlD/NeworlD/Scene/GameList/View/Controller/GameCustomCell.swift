//
//  GameCustomCell.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import UIKit

class GameCustomCell: UITableViewCell {
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var gameName: UILabel!
    @IBOutlet private weak var gameReleaseDate: UILabel!
    @IBOutlet private weak var gameRating: UILabel!
    @IBOutlet private weak var gamePlatforms: UILabel!
    @IBOutlet private weak var gameGenres: UILabel!
    
    func configureCell(model: GameModel) {
        
        for i in model.parentPlatforms {
            gamePlatforms.text! += i.platform.name
        }
        
        gameName.text = model.name
        gameReleaseDate.text = model.released
        gameRating.text = String(model.rating)
        
        gameGenres.text = String(model.genres.count)
        gameImageView.load(url: URL(string: model.backgroundImage) ?? URL(string: Constants.OPPSImageURL)!)
       
        
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        gameImageView.layer.cornerRadius = 20
        self.gameImageView.layer.masksToBounds = true
        self.isUserInteractionEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .black
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10,
                                                                     left: 10,
                                                                     bottom: 10,
                                                                     right: 10))
    }
}
