//
//  ImageService.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 09/04/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import Foundation
import UIKit
class ImageService {
    func fetchQuizImage(ulrString: String,completion: @escaping ((UIImage?) -> Void)){
        
        // ovdje stvaramo URL objekt kojeg mozemo stvoriti iz nekog stringa koji je url
        // ako string nije url onda ovaj failable konstruktor vraca nil
        if let url = URL(string: ulrString) {
            
            // URLRequest objekt stvaramo iz URL objekta
            let request = URLRequest(url: url)
            
            print("creating data task")
            
            // Ovdje stvaramo jedan dataTast objekt, metodom 'dataTask'
            // ta metoda prima URLRequest i funkciju koja prima (Data?, URLResponse?, Error?)
            // pozivom metode 'dataTask.resume()' pokrecemo izvrsavanje URLRequesta predanog dataTask-u, odnosno dohvacanje sadrzaja sa URL-a u URLRequestu
            // Nakon sto se sadrzaj dohvati sa URL-a, izvrsava se blok koda u kojem:
            // - data - dohvaceny byteovi, sadrzaj koji smo dohvatili, u ovom slucaju slika
            // - response - odgovor od servera, tu pisu header-i, status kod i sl
            // - error - pogreska, ako je doslo do greske pri dohvatu
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("fetched image")
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                    print("completion called")
                } else {
                    completion(nil)
                }
            }
            // kraj stvaranja dataTask-a
            
            print("resuming data task")
            // Pokretanje dataTask-a, dohvacanje URL-a
            dataTask.resume()
        } else {
            completion(nil)
        }
    }

}
