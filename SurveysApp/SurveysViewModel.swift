//
//  SurveysDataSource.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/8/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import Foundation
import UIKit

class SurveysViewModel : NSObject  {
    
    var surveys : [Survey] = []
    var pageControl:UIPageControl!
    var didTapTakeSurvey : ((Survey) -> ())!
    let reuseIdentifier = "SurveyCellID"
}

extension SurveysViewModel : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier , for: indexPath) as? SurveyCell
        
        let survey = self.surveys[indexPath.row]
        cell?.titleLabel.text = survey.title
        cell?.descriptionLabel.text = survey.des
        cell?.coverImageView.asyncDownloadImage(url: "\(survey.cover_image_url!)l")
        cell?.takeSurveyButton.didTouchUpInside = { (sender) in
            self.didTapTakeSurvey(survey)}
        
        return cell!
    }
}

extension SurveysViewModel : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index =   scrollView.contentOffset.y / scrollView.frame.size.height;
        pageControl.currentPage = Int(index)
    }
    
}

extension SurveysViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}


