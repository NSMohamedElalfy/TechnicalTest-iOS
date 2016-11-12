//
//  App.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/10/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import Foundation
import UIKit


final class App {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let navigationController: UINavigationController
    
    init(window:UIWindow) {
        navigationController = window.rootViewController as! UINavigationController
        let mainViewController = navigationController.topViewController as! MainViewController
        mainViewController.load(resource: Survey.all)
        mainViewController.didTapTakeSurvey = takeSurvey
        setupSharedURLCache()
    }
    
    func takeSurvey(survey:Survey)  {
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailViewController.survey = survey
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    private func setupSharedURLCache(){
        let sharedCache = URLCache(memoryCapacity: 20*1024*1024, diskCapacity: 100*1024*1024, diskPath: "comSurveysCache")
        URLCache.shared = sharedCache
    }
    
}
