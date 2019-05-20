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
    
    @IBOutlet weak var questionViewFrame: UIScrollView!
    
    @IBOutlet weak var numberOfQuestions: UILabel!
    
    @IBAction func fetchButton(_ sender: Any) {
        fetchQuestions()
        listAllQuestions()
    }
    
    var viewModel: Quiz!
    var slides:[QuestionView] = []
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
    func listAllQuestions(){
        var tocka: CGPoint = questionViewFrame.contentOffset
        tocka.x = tocka.x + slides[0].frame.width
        questionViewFrame.setContentOffset(tocka, animated: true)

        if tocka.x >= view.frame.width * (CGFloat(slides.count)){
            //trajanje = Date.init().timeIntervalSince(pocetak!)
            //startOneQuizButton.isEnabled = false
            questionViewFrame.setContentOffset(CGPoint(x: 0, y:0), animated: true)
            questionViewFrame.isHidden = true
            //var resultText: String = "TRAJANJE: " + String(format: "%.3f",trajanje!)+"\n\n"
            //resultText = resultText+"BROJ TOČNIH ODGOVORA: \n" + String(brojTocnih!)+" / " + String(slides.count)
            //resultLabel.text = resultText
            //resultLabel.isHidden = false
            //print(brojTocnih!)


//            let resultService = ResultService()
//            resultService.loginFunction(urlString: "https://iosquiz.herokuapp.com/api/result", quiz_id: (kvizovi![indexpath!.section])[indexpath!.row].id, user_id: (UserDefaults.standard.integer(forKey: "username") as! Int), time: trajanje!, no_of_correct: brojTocnih!) { _ in }

            // /*
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.navigationController?.popViewController(animated: true)
            }) // */
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
        
    
        self.addCustomView()
    
    
        
        //return errorOccured
    }
    
    
    func addCustomView() {
       
        
        let customView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: questionViewFrame.bounds.size.width, height: questionViewFrame.bounds.size.height)),quiz: viewModel,questionNumber: 1)
        
        questionViewFrame.addSubview(customView)
        questionViewFrame.isHidden = false
    }
    
    override func viewDidLoad() {
        slides = createSlides()
        setupSlideScrollView(slides: slides)
    }
func createSlides() -> [QuestionView] {
    //let kviz: Quiz = (kvizovi![indexpath!.section])[indexpath!.row]
    //var slides: Array<MyQuestionView> = []
    for i in 0..<viewModel.questionList.count{
        

        let questionView = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: view.frame.width, height: view.frame.height)),quiz: viewModel,questionNumber: i )

        
        slides.append(questionView)
    }
    return slides
}
func setupSlideScrollView(slides : [QuestionView]) {
    questionViewFrame.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    questionViewFrame.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
    self.questionViewFrame.contentSize.height = 1.0
    
    
    for i in 0 ..< slides.count {
        slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        //self.setupConstraints(slide: slides[i])
        questionViewFrame.addSubview(slides[i])
        
    }
    questionViewFrame.isHidden = true
    //oneQuizScrollView.isScrollEnabled = false
}
}
