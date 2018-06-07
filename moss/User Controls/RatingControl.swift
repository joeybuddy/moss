//
//  RatingControl.swift
//  moss
//
//  Created by Yufeng Guo on 14/12/2017.
//  Copyright © 2017 Yufeng Guo. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    
    @IBInspectable var starCount: Int32 = 5 {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0)
    {
        didSet {
            setupButtons()
        }
    }
    
    var rating = 0 {
        didSet {
            updateRatingStarStyle()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    // MARK: private methods
    private func setupButtons()
    {
        for button in ratingButtons {
            self.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateRatingStarStyle()
    }
    
    private func updateRatingStarStyle() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    
    @IBAction func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else{
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        }
        else
        {
            rating = selectedRating
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
