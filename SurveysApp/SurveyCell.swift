//
//  SurveyCollectionViewCell.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/8/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import UIKit

class SurveyCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var takeSurveyButton:UIClosureButton!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.image = nil
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        
    }
    
    
    
}
