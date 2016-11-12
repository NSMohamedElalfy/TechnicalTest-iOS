//
//  Networking.swift
//  SurveysApp
//
//  Created by NSMohamedElalfy on 11/12/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import Foundation
import UIKit


public struct API {
    static let baseURL = "https://www-staging.usay.co/app/surveys.json"
    static let accessToken = "6eebeac3dd1dc9c97a06985b6480471211a777b39aa4d0e03747ce6acc4a3369"
}


public typealias JSONDictionary = [String: AnyObject]


public struct Resource<A>{
    public var url:String
    public var parameters : [String : String]?
    public var parse : (Data?) -> A?
    
    public init(url: String, parameters : [String : String]? = nil , parse : @escaping (Data?) -> A? ) {
        self.url = url ; self.parameters = parameters ; self.parse = parse
    }
    
}

extension Resource {
    public init(url: String, parameters : [String : String]? = nil , parseJSON: @escaping (AnyObject?) -> A?) {
        self.url = url
        self.parameters = parameters
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data! , options: []) as AnyObject
            return json.flatMap(parseJSON)
        }
    }
    
}


public enum Result<A> {
    case success(A)
    case error(Error)
}

extension Result {
    public init(_ value: A?, or error: Error) {
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }
    
    public var value: A? {
        guard case .success(let v) = self else { return nil }
        return v
    }
}


public enum WebserviceError: Error {
    case other
}


public final class Webservice {
    
    private let configuration:URLSessionConfiguration
    
    public lazy var session:URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    
    public init(configuration:URLSessionConfiguration = .default) {
        self.configuration = configuration
    }
    
    // uses default configuration
    public class var shared : Webservice {
        struct Static {
            static let instance = Webservice()
        }
        return Static.instance
    }
    
    
    /// Loads a resource. The completion handler is always called on the main queue.
    public func load<A>(resource: Resource<A>,timeoutInterval: TimeInterval = 30 , cachPolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad , completion: @escaping (Result<A>) -> ()) {
        if resource.url.isEmpty{
            return
        }
        
        let url =   resource.parameters != nil ?  resource.url.URLFromString(parameters: resource.parameters) : URL(string: resource.url)
        //Create request with caching policy
        let request = URLRequest(url: url!, cachePolicy: cachPolicy , timeoutInterval: timeoutInterval)
        
        //Get cache response using request object
        if let cacheResponse = URLCache.shared.cachedResponse(for: request) {
            let parsed = resource.parse(cacheResponse.data)
            let result = Result(parsed, or: WebserviceError.other)
            DispatchQueue.main.async{
                completion(result)
                print("cached data")
            }
            return
        }
        
        session.dataTask(with: request){ (data:Data?, response:URLResponse?, error:Error?) in

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode / 100 != 2 {
                    return
                }
                let cacheResponse = CachedURLResponse(response: response! , data: data!)
                URLCache.shared.storeCachedResponse(cacheResponse, for: request)
                let parsed = data.flatMap(resource.parse)
                let result = Result(parsed, or: WebserviceError.other)
                DispatchQueue.main.async{
                    completion(result)
                    print("updated data")
                }
            }
                
        }.resume()
        
    }
    
    func cancelAllLoadingTasks(){
        session.invalidateAndCancel()
    }
    
    func cancelLoadingTask(for url:URL) {
        if #available(iOS 9.0, *) {
            self.session.getAllTasks { (tasks:[URLSessionTask]) in
                tasks.forEach({ (task:URLSessionTask) in
                    if let taskURL = task.originalRequest?.url {
                        if taskURL == url && task.state == .running{
                            task.cancel()
                        }
                    }
                    
                })
            }
        } else {
            // Fallback on earlier versions
            session.getTasksWithCompletionHandler({ (tasks:[URLSessionDataTask], _, _) in
                tasks.forEach({ (task:URLSessionTask) in
                    if let taskURL = task.originalRequest?.url {
                        if taskURL == url && task.state == .running{
                            task.cancel()
                        }
                    }
                    
                })
            })
        }
    }
    
    func clearCache() {
        URLCache.shared.removeAllCachedResponses()
    }
    
    func removeCachedResponse(for request:URLRequest) {
        URLCache.shared.removeCachedResponse(for: request)
    }
    
    
}







