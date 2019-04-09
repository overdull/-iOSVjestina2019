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
        }
    }
    
    
    @IBAction func secondButtonTapped(_ sender: UIButton) {
        if(correctAnswer == 1){
            seccondButtonText.backgroundColor = UIColor.green
        }
    }
    
    @IBAction func thirdButtonTapped(_ sender: UIButton) {
        if(correctAnswer == 2){
            thirdButtonText.backgroundColor = UIColor.green
        }
    }
    
    @IBAction func fourthButtonTapped(_ sender: UIButton) {
        if(correctAnswer == 3){
            fourthButtonText.backgroundColor = UIColor.green
        }
    }
    
    
    
    
    
    
    
    // Slijede nam dva init-a, prvi se poziva kada inicijaliziramo CustomView iz koda, a drugi kada ga inicijaliziramo iz .xib datoteke
    
    // Ovaj init prima pravokutnik u kojem ce se ovaj CustomView iscrtati
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        let quizNumber = 0
        let questionNumber = 3
        
        // ovdje u init-u inicijaliziramo i konfiguriramo subview-ove CustomView-a
//        label = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 40, height: 40)))
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        
        // stvaramo jedan CountryService objekt
        let questionService = QuestionServices()
        
        // i pozivamo njegovu funckiju fetchCountry()
        // Ta funckija prima string s kojeg treba dohvatiti sadrzaj (json drzave) i blok koda koji zelimo da se izvrsi kada se dohvati taj sadrzaj
        questionService.fetchQuestion(urlString: urlString) { (quizzes) in
            // ovdje moramo izvrsiti ovaj kod na main dretvi, vise o tome u iducim predavanjima
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.correctAnswer = quizzes.quiz[quizNumber].questionList[questionNumber].correctAnswer
                   // print(quizzes.quiz[0].questionList[0].answers[0])
                    self.QuestionText.text = quizzes.quiz[quizNumber].questionList[questionNumber].question
                    self.firstButtonText.setTitle(quizzes.quiz[quizNumber].questionList[questionNumber].answers[0], for: .normal)
                    self.seccondButtonText.setTitle(quizzes.quiz[quizNumber].questionList[questionNumber].answers[1], for: .normal)
                    self.thirdButtonText.setTitle(quizzes.quiz[quizNumber].questionList[questionNumber].answers[2], for: .normal)
                    self.fourthButtonText.setTitle(quizzes.quiz[quizNumber].questionList[questionNumber].answers[3], for: .normal)
                }
            }
        }
        
        
        
        
    }
    
    // Ovaj init se poziva kada se CustomView inicijalizira iz .xib datoteke
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        
//        label = UILabel(frame: CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 40, height: 40)))
//        label?.text = "text"
//        label?.backgroundColor = UIColor.blue
//        
//        if let label = label {
//            self.addSubview(label)
//        }

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
