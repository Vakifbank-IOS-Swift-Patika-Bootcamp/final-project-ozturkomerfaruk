//
//  FavouriteList.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 13.12.2022.
//

import UIKit

class FavouriteListVC: UIViewController {
    
    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    var viewModel = FavouriteListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
        viewModel.delegate = self
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "favouriteDetailVC") as? FavouriteDetailVC else { return }
        if let presentationController = vc.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        present(vc, animated: true)
    }
}

extension FavouriteListVC: FavouriteCustomCellDelegate {
    func deleteFavourite(index: Int) {
        viewModel.deleteFavourites(index: index)
    }
}
