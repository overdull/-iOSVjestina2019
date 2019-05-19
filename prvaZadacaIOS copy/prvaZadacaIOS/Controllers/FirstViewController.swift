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

    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizTitle: UILabel!
    
    @IBOutlet weak var QuestionViewFrame: UIView!
    @IBOutlet weak var numberOfQuestions: UILabel!
    
    @IBAction func fetchButton(_ sender: Any) {
        if(!fetchQuestions()){
            addCustomView()
            if let customView2 = Bundle.main.loadNibNamed("QuestionView1", owner: nil, options: [:])?.first as? QuestionView {
                print(customView2)
//                customViewContainer.addSubview(customView2) // zakomentirano jer vec dodajemo gore CustomView stvoren bez .xiba
            }

        }
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
    func fetchQuestions() -> Bool{
        let quizNumber = 2
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let questionService = QuestionServices()
        let imageService = ImageService()
        var errorOccured = false
        
        questionService.fetchQuestion(urlString: urlString) { (quizzes) in

//            let bundle = Bundle(for: type(of: self))
//            let nib = UINib(nibName: "QuestionView1", bundle: bundle)
//            let view = nib.instantiate(withOwner: self, options: nil).first as! QuestionView
//
//
//            let customView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: QuestionViewFrame.bounds.size.width, height: QuestionViewFrame.bounds.size.height)))
//            QuestionViewFrame.addSubview(customView)
//            QuestionViewFrame.isHidden = false

//            customView.firstButtonText.titleLabel?.text =
            
//            customView.question =
            
             var num = 0
             DispatchQueue.main.async {
                if let quizzes = quizzes {
                    for object in quizzes.quiz{
                        num = num + object.questionList.filter{$0.question.contains("NBA")}.count
                        print(object.title)
                        
                    }
                    if let colorCategory = CategoryColor(rawValue: quizzes.quiz[quizNumber].category) {
                        print(colorCategory.description)
                        self.quizTitle.backgroundColor = colorCategory.description
                        self.quizImage.backgroundColor = colorCategory.description
                    }
                    self.quizTitle.text = quizzes.quiz[quizNumber].title
                    self.quizTitle.isHidden = false
                    self.numberOfQuestions.text = "\(num)"
                    imageService.fetchQuizImage(ulrString: quizzes.quiz[quizNumber].imageUrl){ (image) in
                        print("setting image")
                        DispatchQueue.main.async {
                            self.quizImage.image = image
                            self.quizImage.isHidden = false
                        }
                        print("image set")
                    }
                    self.errorMessage.isHidden = true
                    
                }else{
                    self.errorMessage.isHidden = false
                    self.QuestionViewFrame.isHidden = true
                    self.quizTitle.isHidden = true
                    self.quizImage.isHidden = true
                    errorOccured = true
                    self.numberOfQuestions.text = "Fun fact"
                }
            }
        }
        return errorOccured
    }
    
    
    func addCustomView() {
       
        let customView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: QuestionViewFrame.bounds.size.width, height: QuestionViewFrame.bounds.size.height)))
        QuestionViewFrame.addSubview(customView)
        QuestionViewFrame.isHidden = false
    }
    
    override func viewDidLoad() {
        
    }

}
