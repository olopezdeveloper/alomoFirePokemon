//
//  Utilities.swift
//  TareaCertificacion
//
//  Created by Administrador on 12/03/18.
//  Copyright © 2018 Administrador. All rights reserved.
//

import Foundation

import Alamofire

func load_image(_ urlString:String, end:((UIImage?)->())?)
{
    Alamofire.request(urlString).responseData { (response) in
        if response.error == nil {
            // Show the downloaded image:
            if let data = response.data {
                end?(UIImage(data: data))
            }
        }
    }
}
