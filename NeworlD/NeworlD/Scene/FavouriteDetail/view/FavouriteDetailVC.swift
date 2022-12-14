//
//  FavouriteDetailVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 13.12.2022.
//

import UIKit

protocol FavouriteDetailVCDelegate: AnyObject {
    func deleteFavourite(index: Int)
}

class FavouriteDetailVC: UIViewController {
    
    weak var delegate: FavouriteDetailVCDelegate?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgGame: UIImageView!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var lblRelease: UILabel!
    @IBOutlet weak var lblUserReviews: UILabel! // Exceptional
    @IBOutlet weak var btnFavouriteOutler: UIButton!
    
    @IBOutlet private weak var androidIcon: UIImageView!
    @IBOutlet private weak var appleIcon: UIImageView!
    @IBOutlet private weak var windowsIcon: UIImageView!
    @IBOutlet private weak var linuxIcon: UIImageView!
    @IBOutlet private weak var psIcon: UIImageView!
    @IBOutlet private weak var xboxIcon: UIImageView!
    @IBOutlet private weak var webIcon: UIImageView!
    @IBOutlet private weak var nintendoIcon: UIImageView!
    
    
    var gameId: Int?
    private var viewModel = FavouriteDetailViewModel()
    
    private var iconImageViews: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.fetchFavouriteGameDetail(gameId: gameId!)
        viewModel.fetchFavourites()
        
        iconImageViews.append(androidIcon)
        iconImageViews.append(appleIcon)
        iconImageViews.append(windowsIcon)
        iconImageViews.append(linuxIcon)
        iconImageViews.append(psIcon)
        iconImageViews.append(xboxIcon)
        iconImageViews.append(webIcon)
        iconImageViews.append(nintendoIcon)
        
        for i in iconImageViews {
            i.image = i.image?.withRenderingMode(.alwaysTemplate)
            i.tintColor = UIColor.white
            i.isHidden = true
        }
    }
    
    @IBAction func removeFromFavouritesButtonAction(_ sender: Any) {
        for (i, fav) in viewModel.getFavourites().enumerated() {
            if fav.gameId == self.gameId! {
                viewModel.deleteFavourite(fav: fav, index: i)
                self.delegate?.deleteFavourite(index: i)
            }
        }
        
        dismiss(animated: true)
    }
    
    
}

extension FavouriteDetailVC: FavouriteDetailViewModelDelegate {
    func gameLoaded() {
        print(gameId!)
        lblName.text = viewModel.getLblName()
        imgGame.load(url: URL(string: viewModel.getImgGame()!)!)
        lblDescription.text = viewModel.getLblDescription()
        lblRelease.text = viewModel.getLblRelease()
        lblUserReviews.text = viewModel.getLblUserReviews()
        
        for i in viewModel.getParentPlatform() {
            switch platformNameFunc(i.platform.name) {
            case "android":
                androidIcon.isHidden = false
                break
            case "apple":
                appleIcon.isHidden = false
                break
            case "windows":
                windowsIcon.isHidden = false
                break
            case "linux":
                linuxIcon.isHidden = false
                break
            case "ps":
                psIcon.isHidden = false
                break
            case "xbox":
                xboxIcon.isHidden = false
                break
            case "nintendo":
                nintendoIcon.isHidden = false
                break
            case "web":
                webIcon.isHidden = false
                break

            default:
                return
            }
        }
    }
    
    func gameFailed(error: Error) {
        print("Error")
    }
    
    private func platformNameFunc(_ name: String) -> String {
        switch name {
        case "Android":
            return "android"
        case "iOS":
            return "apple"
        case "Apple Macintosh":
            return "apple"
        case "PC":
            return "windows"
        case "Linux":
            return "linux"
        case "PlayStation":
            return "ps"
        case "Xbox":
            return "xbox"
        case "Nintendo":
            return "nintendo"
        case "Web":
            return "web"
        default:
            return ""
        }
    }
}
