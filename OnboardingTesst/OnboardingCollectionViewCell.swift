//
//  OnboardingCollectionViewCell.swift
//  OnboardingTesst
//
//  Created by Адиль Медеуев on 03.03.2021.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet var slideImage: UIImageView!
    @IBOutlet var slideTitle: UILabel!
    @IBOutlet var slideDescription: UILabel!
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    func setup(_ slide: Slide) {
        slideTitle.text = slide.title
        slideDescription.text = slide.description
        slideImage.image = slide.image
    }
}
