//
//  CustomCell.swift
//  TareaCertificacion
//
//  Created by Administrador on 12/03/18.
//  Copyright © 2018 Administrador. All rights reserved.
//

import UIKit
import Alamofire


class PokemonCell: UITableViewCell {
    
    private var pokemon:Pokemon?
    
    @IBOutlet private weak var labelNamePokemon: UILabel!
    @IBOutlet private weak var imagePokemon: UIImageView!
    
    func configureCell(with pokemon: Pokemon) {
        
        labelNamePokemon.text = pokemon.name
        load_image(pokemon.image, end: { (image) in
            self.imagePokemon.image = image
        })
        self.pokemon = pokemon
    }

    

}

