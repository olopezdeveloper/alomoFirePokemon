//
//  DetailViewController.swift
//  TareaCertificacion
//
//  Created by Administrador on 27/03/18.
//  Copyright © 2018 Administrador. All rights reserved.
//

import UIKit
import Alamofire
import NetworkingManager

class DetailViewController: UIViewController {
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelHeight: UILabel!
    @IBOutlet private weak var labelWeight: UILabel!
    @IBOutlet private weak var imagePokemon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func uploadDetail(_ urlPokemon: String) {
        
        NetworkingManager.shared.request(toUrl: urlPokemon, parameters: nil, method: .get, encoding: URLEncoding.default) { (sucess, response) in
            if sucess {
                if let response = response {
                    
                    guard let response = response as? [String:Any]
                        else {
                            return
                    }
                    
                    let results = response
                    let weight = results["weight"] as! NSNumber
                    let height = results["height"] as! NSNumber
                    self.labelWeight.text = weight.stringValue
                    self.labelHeight.text = height.stringValue
                    self.labelName.text = results["name"] as? String
                    
                    let myStringArr = urlPokemon.components(separatedBy: "/")
                    let id = myStringArr[myStringArr.count - 2]
                    let image = "\(URL_IMAGEN_POKEMON)\(id).png"
                    
                    load_image(image, end: { (image) in
                        self.imagePokemon.image = image
                    })
                    
                } else {
                    print("error respose")
                }
            } else {
                print("error")
            }
        }
    }
}

extension DetailViewController:ViewControllerDelegate {
    func openDetail(_ pokemonId: String) {
        uploadDetail(pokemonId)
    }
}
