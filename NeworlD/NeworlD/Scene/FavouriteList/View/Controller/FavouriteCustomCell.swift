//
//  FavouriteCustomCell.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 13.12.2022.
//

import UIKit

protocol FavouriteCustomCellDelegate: AnyObject {
    func deleteFavourite(index: Int)
}

class FavouriteCustomCell: UICollectionViewCell {
    
    weak var delegate: FavouriteCustomCellDelegate?
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favouriteButtonOutlet: UIButton!
    
    var index: Int?
    
    func configureCustomCell(fav: FavouritesEntity?) {
//        imageView.load(url: URL(string: Constants.OPPSImageURL)!)
//        titleLabel.text = model.name
        titleLabel.text = String(fav?.gameId ?? -1)
        
        
        favouriteButtonOutlet.layer.cornerRadius = favouriteButtonOutlet.frame.width / 2
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        print("Custom Celldeyim")
        delegate?.deleteFavourite(index: index!)
    }
    
}
