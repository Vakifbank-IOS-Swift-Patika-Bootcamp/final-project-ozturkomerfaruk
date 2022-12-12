//
//  FilterView.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 10.12.2022.
//

import UIKit

protocol FilterViewDelegate: AnyObject {

    func didTapped()
    func sortAtoZ()
    func sortZtoA()
    func sortNewest()
    func sortOldest()
    func sortHighest()
    func sortLowest()
    func sortRecentlyAdded()
}

class FilterView: UIView {
    
    weak var delegate: FilterViewDelegate?
    private var isDetailedNow = false
    
    @IBOutlet private weak var closePopOutlet: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        configureFilterView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureFilterView()
    }
}

extension FilterView {
    @IBAction func sortByNameAtoZ(_ sender: Any) {
        delegate?.sortAtoZ()
        removeFromSuperview()
    }
    
    @IBAction func sortByNameZtoA(_ sender: Any) {
        delegate?.sortZtoA()
        removeFromSuperview()
    }
    
    @IBAction func sortByNewest(_ sender: Any) {
        delegate?.sortNewest()
        removeFromSuperview()
    }
    
    @IBAction func sortByOldest(_ sender: Any) {
        delegate?.sortOldest()
        removeFromSuperview()
    }
    
    @IBAction func sortByHighest(_ sender: Any) {
        delegate?.sortHighest()
        removeFromSuperview()
    }
    
    @IBAction func sortByLowest(_ sender: Any) {
        delegate?.sortLowest()
        removeFromSuperview()
    }
    
    @IBAction func sortByRecentlyAdded(_ sender: Any) {
        delegate?.sortRecentlyAdded()
        removeFromSuperview()
    }
}

extension FilterView {
    func configureFilterView() {
        closePopOutlet.layer.cornerRadius = closePopOutlet.frame.height / 2
    }
    
    @IBAction func closePopAction(_ sender: Any) {
        removeFromSuperview()
    }
    
    private func xibSetup(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }
    
    private func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "FilterView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }
}
