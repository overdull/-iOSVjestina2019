//
//  FirstViewController.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 30/03/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import UIKit
import Foundation
class FirstViewController: UIViewController {
    var fetchedQuizzes: FetchedQuizzes!
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizTitle: UILabel!
    
    @IBOutlet weak var QuestionViewFrame: UIView!
    @IBOutlet weak var numberOfQuestions: UILabel!
    
    @IBAction func fetchButton(_ sender: Any) {
        fetchQuestions()
        
    }
    
    var viewModel: Quiz!
    
    convenience init(viewModel: Quiz) {
        self.init()
        self.viewModel = viewModel
        
    }
    enum CategoryColor: String {
        
        case yellow = "SCIENCE"
        case red = "SPORTS"
        
        var description: UIColor {
            switch self {
            case .yellow:
                return UIColor.yellow
            case .red:
                return UIColor.purple
            }
        }
    }
    func fetchQuestions() {
        //let quizNumber = 2
        //let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        //let questionService = QuestionServices()
        //let imageService = ImageService()
        //var errorOccured = false
        
        
        
        if let colorCategory = CategoryColor(rawValue: viewModel.category) {
            print(colorCategory.description)
            self.quizTitle.backgroundColor = colorCategory.description
            self.quizImage.backgroundColor = colorCategory.description
        }
        self.quizTitle.text = viewModel.title
        self.quizTitle.isHidden = false

        self.errorMessage.isHidden = true
        
    
        //self.addCustomView()
    
    
        
        //return errorOccured
    }
    
    
    func addCustomView() {
       
        let customView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: QuestionViewFrame.bounds.size.width, height: QuestionViewFrame.bounds.size.height)),fetchedQuizzes: self.fetchedQuizzes)
        
        QuestionViewFrame.addSubview(customView)
        QuestionViewFrame.isHidden = false
    }
    
    override func viewDidLoad() {
        
    }

}
