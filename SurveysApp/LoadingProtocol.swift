//
//  LoadingProtocol.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/10/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift


protocol Loading {
    associatedtype ResourceType
    var spinner: UIActivityIndicatorView { get }
    func configure(value: ResourceType)
    func alert(message:String)
}

extension Loading where Self: UIViewController {
    
    func load(resource: Resource<ResourceType>) {
        spinner.startAnimating()
        let reachability = Reachability()!
        do {
            try reachability.startNotifier()
        } catch {
            self.alert(message: "Unable to start notifier")
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async{
                self.spinner.stopAnimating()
                self.alert(message: "Networking Error : You are Offline Please Check your Connection")
            }
        }
        reachability.whenReachable = { reachability in
            Webservice.shared.load(resource: resource) { [weak self] result in
                self?.spinner.stopAnimating()
                guard let value = result.value else{self?.alert(message: "Networking Error :  Loading is Failed") ; return }
                self?.configure(value: value)
                reachability.stopNotifier()
            }
        }
        
        
    
    }
}
