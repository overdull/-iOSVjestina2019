//
//  QuestionView.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 31/03/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    var correctAnswer = -1
    var view: UIView!
    
    var label: UILabel?
    
    @IBOutlet weak var QuestionText: UILabel!
    
    @IBOutlet weak var firstButtonText: UIButton!
    
    @IBOutlet weak var seccondButtonText: UIButton!
    
    @IBOutlet weak var thirdButtonText: UIButton!
    
    @IBOutlet weak var fourthButtonText: UIButton!
    
    @IBAction func firstButtonTapped(_ sender: UIButton) {
        if(correctAnswer == 0){
            firstButtonText.backgroundColor = UIColor.green
        }else{
            firstButtonText.backgroundColor = UIColor.red
        }
    }
    
    
    @IBAction func secondButtonTapped(_ sender: UIButton) {
        if(correctAnswer == 1){
            seccondButtonText.backgroundColor = UIColor.green
        }else{
            seccondButtonText.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func thirdButtonTapped(_ sender: UIButton) {
        if(correctAnswer == 2){
            thirdButtonText.backgroundColor = UIColor.green
        }else{
            thirdButtonText.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func fourthButtonTapped(_ sender: UIButton) {
        if(correctAnswer == 3){
            fourthButtonText.backgroundColor = UIColor.green
        }else{
            fourthButtonText.backgroundColor = UIColor.red
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        let quizNumber = 1
        let questionNumber = 9
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let questionService = QuestionServices()
        
       
        questionService.fetchQuestion(urlString: urlString) { (quizzes) in
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.correctAnswer = quizzes.quiz[quizNumber].questionList[questionNumber].correctAnswer
       
                    self.QuestionText.text = quizzes.quiz[quizNumber].questionList[questionNumber].question
                   self.QuestionText.isHidden = false
                    self.firstButtonText.setTitle(quizzes.quiz[quizNumber].questionList[questionNumber].answers[0], for: .normal)
                    self.firstButtonText.isHidden = false
                    
                    self.seccondButtonText.setTitle(quizzes.quiz[quizNumber].questionList[questionNumber].answers[1], for: .normal)
                    self.seccondButtonText.isHidden = false
                    self.thirdButtonText.setTitle(quizzes.quiz[quizNumber].questionList[questionNumber].answers[2], for: .normal)
                    self.thirdButtonText.isHidden = false
                    self.fourthButtonText.setTitle(quizzes.quiz[quizNumber].questionList[questionNumber].answers[3], for: .normal)
                    self.fourthButtonText.isHidden = false
                }
            }
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setup(){
        view = loadViewFromNib()
        view.frame = self.bounds
        addSubview(view)
    }
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "QuestionView1", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

}
