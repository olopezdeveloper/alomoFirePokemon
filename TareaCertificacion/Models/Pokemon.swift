//
//  Pokemon.swift
//  TareaCertificacion
//
//  Created by Administrador on 26/03/18.
//  Copyright © 2018 Administrador. All rights reserved.
//

import Foundation

class Pokemon {
    var id: Int
    var name: String
    var image: String
    var url: String
    
    init(id: Int, name: String, image: String, url: String) {
        self.id = id
        self.name = name
        self.image = image
        self.url = url
    }
}
