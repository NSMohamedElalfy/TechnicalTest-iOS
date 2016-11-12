//
//  Survey.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/8/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import Foundation

public struct  Survey  {
    
    var id : String?
    var title : String?
    var des : String?
    var cover_image_url:String?
    var type : String?
    
    init(id:String , title : String , description : String , coverImageURL : String , type:String) {
        self.id = id ; self.title = title ; self.cover_image_url = coverImageURL ; self.des = description ; self.type = type
    }
}

extension Survey {
    
        init?(dictionary:JSONDictionary){
            guard let id = dictionary["id"] as? String ,let title = dictionary["title"] as? String , let des = dictionary["description"] as? String  , let cover_image_url = dictionary["cover_image_url"] as? String , let type = dictionary["type"] as? String
                else {return nil}
            self.id = id ; self.title = title ; self.cover_image_url = cover_image_url ; self.des = des ; self.type = type
        }
    
}


extension Survey {
    static let all = Resource<[Survey]>(url: API.baseURL , parameters: ["access_token" : API.accessToken], parseJSON: { json in
        guard let dictionaries = json as? [JSONDictionary] else { return nil }
        return dictionaries.flatMap(Survey.init)
    })
    
}

