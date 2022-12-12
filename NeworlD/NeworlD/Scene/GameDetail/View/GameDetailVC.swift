//
//  GameDetailVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 9.12.2022.
//

import UIKit
import iCarousel

//MARK: Yapılacaklar Listesi Bu Sayfaya
///Webview link boşsa başka bir siteye yönlendir

final class GameDetailVC: UIViewController {
    
    @IBOutlet private weak var tagsTableView: UITableView!
    @IBOutlet private weak var ratingsTableView: UITableView!
    
    @IBOutlet private weak var descriptionRaw: UILabel!
    @IBOutlet private weak var gameName: UILabel!
    @IBOutlet private weak var gamePublisher: UILabel!
    
    @IBOutlet private weak var scrollView: UIScrollView!

    @IBOutlet private weak var oppsImage: UIImageView!
    
    
    @IBOutlet private weak var favouriteOutletButton: UIButton!
    @IBOutlet private weak var setAddNoteOutletButton: UIButton!
    
    //MARK: ViewModel'den çekilecek bu - CoreData'dan gelecek
    private var isFavourite = Bool()
    
    var model: GameModel?
    private var viewModel = GameDetailViewModel()
    
    private let myCarousel: iCarousel = {
        let view = iCarousel()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = .white
        
        guard let model = model else { return }
        viewModel.fetchGameDetail(id: model.id)
        viewModel.delegate = self
        
        setConfigureCarouselImages()
        setConfigureTableView()
        
        setNavigationItemButton()
        setFavouriteOutlet()
        setAddNoteOutlet()
        print(viewModel.iCorouselImagesCount(model: model))
        oppsImage.isHidden = true
        if viewModel.iCorouselImagesCount(model: model) == 0 {
            oppsImage.isHidden = false
            oppsImage.load(url: URL(string: Constants.OPPSImageURL)!)
        }
    }
    
    private func setNavigationItemButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Game Website", style: .plain, target: self, action: #selector(goToWebsite))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func goToWebsite() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "gameWebsiteVC") as? GameWebsiteVC else { return }
        vc.gameWebsiteURLString = viewModel.getWebsiteURLString()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setConfigureTableView() {
        tagsTableView.backgroundColor = .clear
        ratingsTableView.backgroundColor = .clear
        
        tagsTableView.delegate = self
        tagsTableView.dataSource = self
        tagsTableView.register(UINib(nibName: "TagsCustomCell", bundle: nil), forCellReuseIdentifier: "tagsCustomCell")
        
        ratingsTableView.delegate = self
        ratingsTableView.dataSource = self
        ratingsTableView.register(UINib(nibName: "RatingsCustomCell", bundle: nil), forCellReuseIdentifier: "ratingsCustomCell")
        
        //Boş olduğu zaman tableview boşa yer kaplamaması için hidden yaptım.
        if model?.tags.count == 0 {
            tagsTableView.isHidden = true
        }
    }
    
    private func setConfigureCarouselImages() {
        view.addSubview(myCarousel)
        myCarousel.dataSource = self
        
        myCarousel.frame = CGRect(x: 0, y: 30, width: view.frame.size.width, height: 400)
        myCarousel.type = .rotary
        myCarousel.autoscroll = -0.3
    }
    
}

extension GameDetailVC {
    private func setFavouriteOutlet() {
        favouriteOutletButton.layer.cornerRadius = favouriteOutletButton.frame.height / 2
    }
    
    @IBAction func favouriteActionButton(_ sender: Any) {
        
        favouriteOutletButton.setImage(UIImage(systemName: isFavourite ? "heart" : "heart.fill"), for: .normal)
        isFavourite = !isFavourite
        
        print(isFavourite ? "Favoride" : "Değil")
    }
    
    private func setAddNoteOutlet() {
        setAddNoteOutletButton.layer.cornerRadius = setAddNoteOutletButton.frame.height / 2
    }
    
    @IBAction func setAddNoteAction(_ sender: Any) {
        
        print("Not Ekleme Sayfası")
    }
}

extension GameDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tagsTableView:
            return model?.tags.count ?? 0
        case ratingsTableView:
            return viewModel.getRatingTableCount()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tagsTableView:
            guard let tagCell = tableView.dequeueReusableCell(withIdentifier: "tagsCustomCell", for: indexPath) as? TagsCustomCell else { return UITableViewCell() }
            tagCell.configureTagsCustomCell(tagModel: (model?.tags[indexPath.row])!)
            return tagCell
        case ratingsTableView:
            guard let ratingCell = tableView.dequeueReusableCell(withIdentifier: "ratingsCustomCell", for: indexPath) as? RatingsCustomCell else { return UITableViewCell() }
            ratingCell.configureCustomCell(model: viewModel.getRating(index: indexPath.row)!)
            return ratingCell
        default:
            return UITableViewCell()
        }
    }
}

extension GameDetailVC: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return viewModel.iCorouselImagesCount(model: self.model!)
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/1.13, height: 250))
        view.backgroundColor = .systemGray
        let imageview = UIImageView(frame: view.bounds)
        view.addSubview(imageview)
        imageview.contentMode = .scaleToFill
        imageview.load(url: URL(string: viewModel.iCorouselImagesArray(model: model!)[index])!)
        return view
    }
}

extension GameDetailVC: GameDetailViewModelDelegate {
    func gamesLoaded() {
        descriptionRaw.text = viewModel.getDescriptionRow()
        gameName.text = model?.name
        gamePublisher.text = viewModel.getPublisher()
        
        tagsTableView.reloadData()
        ratingsTableView.reloadData()
        
        if viewModel.getRatingTableCount() == 0 {
            self.tagsTableView.isHidden = true
            print("if de")
        }
    }
    
    func gamesFailed(error: Error) {
        print("VieW ModeL ErroR")
    }
}
