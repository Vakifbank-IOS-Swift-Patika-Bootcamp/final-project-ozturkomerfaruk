//
//  GameDetailVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 9.12.2022.
//

import UIKit
import iCarousel

class GameDetailVC: UIViewController {
   
    @IBOutlet private weak var name: UILabel!
    
    var model: GameModel?
    private var viewModel = GameDetailViewModel()
    
    private let myCarousel: iCarousel = {
        let view = iCarousel()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let model = model else { return }
        viewModel.fetchGameDetail(id: model.id)
        viewModel.delegate = self
        
        
        setConfigureCarouselImages()
        
    }
    
    private func setConfigureCarouselImages() {
        view.addSubview(myCarousel)
        myCarousel.dataSource = self
        
        myCarousel.frame = CGRect(x: 0, y: 30, width: view.frame.size.width, height: 400)
        myCarousel.type = .rotary
        myCarousel.autoscroll = -0.3
    }
}

extension GameDetailVC: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return viewModel.iCorouselImagesCount(model: self.model!)
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/1.3, height: 250))
        view.backgroundColor = .systemGray
        let imageview = UIImageView(frame: view.bounds)
        view.addSubview(imageview)
        imageview.contentMode = .scaleAspectFit
        
        imageview.load(url: URL(string: viewModel.iCorouselImagesArray(model: model!)[index]) ?? URL(string: Constants.OPPSImageURL)!)
        
        return view
    }
    
}

extension GameDetailVC: GameDetailViewModelDelegate {
    func gamesLoaded() {
        name.text = model?.name
        
    }
    
    func gamesFailed(error: Error) {
        print("VieW ModeL ErroR")
    }
}
