//
//  OnboardingVC.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 16.12.2022.
//

import UIKit

final class OnboardingVC: UIViewController {
    
    @IBOutlet private weak var btnNext: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    
    private var viewModel = OnboardingViewModel()
    private var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == viewModel.countSlide() - 1 {
                btnNext.setTitle("Play Time 🎮", for: .normal)
            } else {
                btnNext.setTitle("Next 👾", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureOnboardingVC()
    }
    
    func configureOnboardingVC() {
        collectionView.delegate = self
        collectionView.dataSource = self
        btnNext.layer.cornerRadius = btnNext.frame.height / 2
 
        viewModel.appendSlide(model: OnboardingModel(title: "Neworld GameS", description: "There are millions of game content.", lottieViewStr: LottieNames.games.rawValue))
        viewModel.appendSlide(model: OnboardingModel(title: "Favourites", description: "You can add games to favourite view.", lottieViewStr: LottieNames.favourites.rawValue))
        viewModel.appendSlide(model: OnboardingModel(title: "Notes", description: "You can add and update special notes for each game.", lottieViewStr: LottieNames.notes.rawValue))
        pageControl.numberOfPages = viewModel.countSlide()
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        if currentPage == viewModel.countSlide() - 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .coverVertical
            LaunchOnboardingManager.shared.setIsNotNewUser()
            print(LaunchOnboardingManager.shared.setIsNotNewUser())
            present(vc, animated: true, completion: nil)
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countSlide()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCustomCell", for: indexPath) as! OnboardingCustomCell
        print(viewModel.getSlideModel(at: indexPath.row))
        cell.configureCustomCell(viewModel.getSlideModel(at: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
