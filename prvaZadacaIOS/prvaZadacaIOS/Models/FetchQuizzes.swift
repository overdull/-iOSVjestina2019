//
//  FetchQuizzes.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 07/04/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import Foundation
class FetchQuizzes  {
    var quiz: [Quizzes] = []
    
    init?(json: [String:AnyObject]) {
        
        
        
        
        
        if let json1 = json["quizzes"] as? [[String:Any]]{
            // access nested dictionary values by key
            //questionList = [Question(id: 0, question: "", answers: ["",""], correctAnswer: 0)]
            for object in json1{
                
                if let idQuizz = object["id"] as? Int,
                    let title = object["title"] as? String,
                    let description = object["description"] as? String,
                    let category = object["category"] as? String,
                    let level = object["level"] as? Int,
                    let imageUrl = object["image"] as? String{
                    
                    var questionList: [Question] = []
                    if let jsonDict1 = object["questions"] as? [[String: Any]]{
                        for object1 in jsonDict1{
                            if let idQuestion = object1["id"] as? Int, // za kljuc "name",
                                let question = object1["question"] as? String, // za kljuc
                                let correctAnswer = object1["correct_answer"] as? Int,
                                let answers = object1["answers"] as? [String]{
                                //print(question)
                                
                                let question123 = Question(id: idQuestion,question: question,answers: answers,correctAnswer: correctAnswer)
                                questionList.append(question123)
                            }
                        }
                        
                        
                    }
                    
                    //print("izaso iz for petlje")
                    quiz.append(Quizzes(idQuizz: idQuizz, title: title, description: description, category: category,level:level, imageUrl: imageUrl,  questionList: questionList))
                }
                
            }
        }
    }
}
