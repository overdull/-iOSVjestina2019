//
//  QuestionServices.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 31/03/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import Foundation
class QuestionServices{
    func fetchQuestion(urlString: String, completion: @escaping ((FetchQuizzes?) -> Void)) {
        //provjeravamo odgovara li predani string urlu
        if let url = URL(string: urlString) {
            //pretvorimo ga u url request
            let request = URLRequest(url: url)
            
            
            //proucit
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    
                   
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        let quizzes = FetchQuizzes(json: json as! [String : AnyObject])
                        completion(quizzes)
                    } catch {
                        completion(nil)
                    }
                    
                    
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
