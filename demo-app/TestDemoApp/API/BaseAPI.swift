/*
 Copyright © 2019 OST.com Inc
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 */

import Foundation
import Alamofire

class BaseAPI {
    
    static var mappyServerURL: String {
        let mappyEndpoint = CurrentEconomy.getInstance.mappyApiEndpoint!
        let tokenId = CurrentEconomy.getInstance.tokenId!
        let urlId = CurrentEconomy.getInstance.urlId!
        return "\(mappyEndpoint)api/\(tokenId)/\(urlId)"
    }
    
    class func post(resource:String,
                    params: [String: AnyObject]?,
                    onSuccess: (([String: Any]?) -> Void)?,
                    onFailure: (([String: Any]?) -> Void)?) {
        
        let url = BaseAPI.mappyServerURL + resource
        
        let dataRequest = Alamofire.request(url, method: .post, parameters: params)
        dataRequest.responseJSON { (httpResonse) in
            print("POST: \(url)", httpResonse.result.value as AnyObject)
           
            if (httpResonse.result.isSuccess && httpResonse.response!.statusCode >= 200 && httpResonse.response!.statusCode < 300) {
                // Call Success
                onSuccess?(httpResonse.result.value as? [String: Any])
            } else if (httpResonse.result.isSuccess && httpResonse.response!.statusCode == 401) {
                // Unauthorized.
                
            } else {
                onFailure?(httpResonse.result.value as? [String: Any])
            }
        }
    }
    
    class func get(resource:String,
                   params: [String: AnyObject]?,
                   onSuccess: (([String: Any]?) -> Void)?,
                   onFailure: (([String: Any]?) -> Void)?) {
        
        let url = BaseAPI.mappyServerURL + resource
        
        let dataRequest = Alamofire.request(url, method: .get, parameters: params)
        dataRequest.responseJSON { (httpResonse) in
            print("GET: \(url)", httpResonse.result.value as AnyObject)

            if (httpResonse.result.isSuccess && httpResonse.response!.statusCode >= 200 && httpResonse.response!.statusCode < 300) {
                // Call Success
                onSuccess?(httpResonse.result.value as? [String: Any])
            } else if (httpResonse.result.isSuccess && httpResonse.response!.statusCode >= 400 && httpResonse.response!.statusCode < 500) {
                // Unauthorized.
                
            } else {
                onFailure?(httpResonse.result.value as? [String: Any])
            }
        }
    }
}
