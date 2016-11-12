//
//  Extensions.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/12/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import Foundation
import UIKit


//  extensions for formatting url with parameters
extension String {
    func URLFromString(parameters : [String:String]?) -> URL {
        if let parameters = parameters {
            var components = URLComponents(string: self)!
            var queryItems = [URLQueryItem]()
            
            for (key , value) in parameters {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            components.queryItems = queryItems as [URLQueryItem]?
            return components.url! as URL
        }else{
            return URL(string: self)!
        }
    }
    
    func escape() -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? self
    }
}


extension UIImageView {
    func asyncDownloadImage(url:String , parameters : [String : String]? = nil) {
        
        let resource = Resource(url: url, parameters: parameters) { data in
            return data.flatMap(UIImage.init)
        }
        
        Webservice.shared.load(resource: resource) { result in
            guard let value = result.value else { self.image = UIImage(named:"defaultImage") ; return }
            self.image = value
        }
    }
}

