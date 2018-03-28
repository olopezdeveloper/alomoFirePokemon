//
//  ViewController.swift
//  TareaCertificacion
//
//  Created by Administrador on 12/03/18.
//  Copyright © 2018 Administrador. All rights reserved.
//

import UIKit
import Alamofire
import NetworkingManager

protocol ViewControllerDelegate {
    func openDetail(_ pokemonId: String)
}

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var delegate:ViewControllerDelegate?
    
    private var pokemons = [Pokemon]()
    private var pokemonSeleccionado = Pokemon(id: 1, name: "", image: "", url: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    
    func loadData() {
        NetworkingManager.shared.request(toUrl: URL_BASE_POKEMONS, parameters: nil, method: .get, encoding: URLEncoding.default) { (sucess, response) in
            if sucess {
                if let response = response {
                    
                    
                    guard let response = response as? [String:Any]
                        else {
                            return
                    }
                    
                    
                    let results = response["results"] as! [[String:Any]]
                    
                    for item in results{
                        
                        let url = item["url"] as! String
                        let name = item["name"] as! String
                        
                        let myStringArr = url.components(separatedBy: "/")
                        let id = myStringArr[myStringArr.count - 2]
                        let image = "\(URL_IMAGEN_POKEMON)\(id).png"
                        
                        let pokemon = Pokemon.init(id: Int(id)!, name: name, image: image, url: url)
                        self.pokemons.append(pokemon)
                        
                    }
                    self.tableview.reloadData()
                    
                    
                } else {
                    print("error respose")
                }
            } else {
                print("error")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detalle = segue.destination as? DetailViewController {
            self.delegate = detalle.self
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        cell.configureCell(with: pokemons[indexPath.row])
        return cell
    }
    
    //5. metodo cuando selecciona una celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonSeleccionado = pokemons[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.openDetail(pokemonSeleccionado.url)
    }
    
}

