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
        fetchQuestions()
        addCustomView()
    }
    enum CategoryColor: String {
    
        case grey = "SCIENCE"
        case red = "SPORTS"
        
        var description: UIColor {
            switch self {
            case .grey:
                return UIColor.gray
            case .red:
                return UIColor.purple
            }
        }
    }
    func fetchQuestions() {
        let quizNumber = 0
       
        
        // provjeravamo je li tekst zapisan u textField-u nil, ako je izlazimo iz metode
//        guard let text = textField.text else {
//            return
//        }
        
        // ako smo u text napisali neki kod drzave, npr. hr, be, us i sl. onda ce se s ovog URL-a dohvatiti json sa podacima o drzavi
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        
        // stvaramo jedan CountryService objekt
        let questionService = QuestionServices()
        let imageService = ImageService()
        // i pozivamo njegovu funckiju fetchCountry()
        // Ta funckija prima string s kojeg treba dohvatiti sadrzaj (json drzave) i blok koda koji zelimo da se izvrsi kada se dohvati taj sadrzaj
        
        questionService.fetchQuestion(urlString: urlString) { (quizzes) in
            // ovdje moramo izvrsiti ovaj kod na main dretvi, vise o tome u iducim predavanjima
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
                    
                }
                else{
                    self.errorMessage.isHidden = false
                }
            }
        }
        
    }
    
    //treba dodati ovdje nib o poslat listu kvizova odnosno jedan kviz?
    func addCustomView() {
       
            //QuestionViewFrame.addSubview(questionView)
            
            // U CustomView.xib imamo samo jedan UIView objekt i sa property-jem 'first' dohvacamo taj prvi UIView, koji je zapravo CustomView pa ga mozemo cast-ati
            // Ovo mozete koristiti kao kod za stvaranje View-a iz .xiba, vise cu o ovome reci na sljedecem predavanju, ako vas buni koristite stvaranj View-a kroz 'frame' konstruktor
            // U ovom slucaju pri inicijalizaciji CustomView-a poziva se 'coder' konstruktor
        let customView3 = QuestionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: QuestionViewFrame.bounds.size.width, height: QuestionViewFrame.bounds.size.height)))
//        let customView3 = QuestionView()
        
        
        
        
        QuestionViewFrame.addSubview(customView3)
                
                // zakomentirano jer vec dodajemo gore CustomView stvoren bez .xiba
            
            QuestionViewFrame.isHidden = false
        
            //print("dodajem kastom vju")
        
    }
    
    
    
    
    override func viewDidLoad() {
        
    }


    
    @objc func test() {
        
    }
}
