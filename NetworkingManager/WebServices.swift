//
//  WebServices.swift
//  TareaCertificacion
//
//  Created by Administrador on 25/03/18.
//  Copyright © 2018 Administrador. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkingManager:NSObject {
    
    public static let shared = NetworkingManager()
    
    private override init() {
        
    }
    
    //MARK:- Private class func
    public func request(toUrl url:String
        , parameters:[String:Any]?
        , method:HTTPMethod
        , encoding: ParameterEncoding
        , completed:@escaping (_ success:Bool, _ response:Any?)->()) {
        
        Alamofire.request(url
            , method: method
            , parameters: parameters
            , encoding: encoding
            ).responseJSON { (response) in
                let result = response.result
                if result.isFailure {
                    completed(false, nil)
                } else {
                    do {
                        let itemsResponse = try JSONSerialization.jsonObject(with: response.data!, options: [])
                        completed(true, itemsResponse)
                    } catch {
                        completed(false, nil)
                    }
                }
        }
    }
}

