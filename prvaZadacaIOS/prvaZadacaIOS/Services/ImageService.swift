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
        
        if let url = URL(string: ulrString) {
            let request = URLRequest(url: url)
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
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
}
