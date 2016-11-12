//
//  MainViewController.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/8/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , Loading
{

    @IBOutlet weak var surveysCollectionView : UICollectionView!
    @IBOutlet weak var pageControl:UIPageControl!
    
    var didTapTakeSurvey : (Survey) -> () = { _ in }
    var spinner = UIActivityIndicatorView(activityIndicatorStyle:.white)
    
    let surveysViewModel = SurveysViewModel()
    
    func configure(value: [Survey]) {
        surveysViewModel.surveys = value.reversed()
        pageControl.numberOfPages = value.count
        surveysCollectionView.reloadData()
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSurveyCollectionView()
        setupPageControlView()
        setupSpinner()
        
    }
    
    
    func setupSurveyCollectionView(){
        view.addSubview(surveysCollectionView)
        surveysCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        surveysCollectionView.dataSource = surveysViewModel
        surveysCollectionView.delegate = surveysViewModel
        
        surveysViewModel.pageControl = pageControl
        surveysViewModel.didTapTakeSurvey = didTapTakeSurvey
        
        let top = NSLayoutConstraint(item: surveysCollectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: surveysCollectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: surveysCollectionView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: surveysCollectionView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([top,bottom,right,left])
        view.layoutIfNeeded()
    }
    
    func setupPageControlView(){
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: pageControl, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 15)
        let bottom = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -15)
        let right = NSLayoutConstraint(item: pageControl, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15)
        let width = NSLayoutConstraint(item: pageControl, attribute: .width, relatedBy: .equal, toItem: nil , attribute: .notAnAttribute, multiplier: 1, constant: 15)
        NSLayoutConstraint.activate([top,bottom,right,width])
        view.layoutIfNeeded()
    }
    
    func setupSpinner(){
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([centerX,centerY])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func refresh(sender:UIBarButtonItem){
        load(resource: Survey.all)
    }
    
    @IBAction func goToUp(sender : UIBarButtonItem){
        let indexPath = IndexPath(item: 0, section: 0)
        surveysCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
