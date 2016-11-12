//
//  DetailViewController.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/10/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var coverImageView:UIImageView!
    @IBOutlet weak var titleLable:UILabel!
    @IBOutlet weak var descriptionTextView:UITextView!
    
    
    var survey:Survey?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let unwrappedValue = survey {
            titleLable.text = unwrappedValue.title
            descriptionTextView.text = unwrappedValue.des
            coverImageView.asyncDownloadImage(url: unwrappedValue.cover_image_url!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
