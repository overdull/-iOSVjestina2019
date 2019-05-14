//
//  Quizzes.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 31/03/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//



import Foundation
class Quizzes  {
    let idQuizz: Int
    let title: String
    let description: String
    let category: String
    let level: Int
    let imageUrl: String
    let questionList: [Question] 
    
    init(idQuizz: Int, title: String,description: String, category: String,level: Int, imageUrl: String, questionList: [Question]) {
        self.idQuizz = idQuizz
        self.title = title
        self.description = description
        self.category = category
        self.level = level
        self.imageUrl = imageUrl
        self.questionList = questionList
    }
    
}
