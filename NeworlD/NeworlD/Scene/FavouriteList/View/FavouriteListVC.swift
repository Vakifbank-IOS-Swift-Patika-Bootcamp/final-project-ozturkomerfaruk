//
//  FavouriteList.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 13.12.2022.
//

import UIKit

class FavouriteListVC: UIViewController {
    
    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    private var viewModel = FavouriteListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
        viewModel.delegate = self
        viewModel.fetchFavourites()
        viewModel.delegate?.favouritesLoaded()
    }

}

extension FavouriteListVC: FavouriteListDelegate {
    func favouritesLoaded() {
        favouritesCollectionView.reloadData()
    }
    
    func favouritesFailed(error: Error) {
        print("Error!!!!!!")
    }
}

extension FavouriteListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getFavouritesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCustomCell", for: indexPath) as? FavouriteCustomCell else { return UICollectionViewCell() }
        let fav = viewModel.getFavourites(index: indexPath.row)
        cell.configureCustomCell(fav: fav)
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
}

extension FavouriteListVC: FavouriteCustomCellDelegate {
    func deleteFavourite(index: Int) {
        print("listtteyim")
        viewModel.deleteFavourites(index: index)
    }
}
