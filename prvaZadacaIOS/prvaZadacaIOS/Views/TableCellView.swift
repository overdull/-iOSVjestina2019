//
//  TableCellView.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 12/05/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import UIKit

class TableCellView: UITableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   let imageService = ImageService()
    @IBOutlet weak var quizImage: UIImageView!
    
    @IBOutlet weak var thirdStar: UIImageView!
    
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var quizName: UILabel!
    @IBOutlet weak var quizDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        quizName.font = UIFont.systemFont(ofSize: 18)
        quizName.textColor = UIColor.brown
        quizDescription.font = UIFont.systemFont(ofSize: 16)
        quizDescription.textColor = UIColor.gray
        quizDescription.numberOfLines = 5
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        titleLabel.text = ""
//        timeLabel.text = ""
//        descriptionLabel.text = ""
//        reviewImageView?.image = nil
//    }
//    
//    func setup(withReview review: ReviewCellModel) {
//        titleLabel.text = review.title
//        timeLabel.text = review.date
//        descriptionLabel.text = review.summary
//        
//        
//    }
    
    func setup(withQuiz quiz: Quiz) {
        quizName.text = quiz.title
        quizDescription.text = quiz.description
        if quiz.level >= 1{
            self.firstStar.isHidden = false
        }
        if quiz.level >= 2{
            self.secondStar.isHidden = false
        }
        if quiz.level >= 3{
            self.thirdStar.isHidden = false
        }
        
        
        // Dohvacanje slike URLSession-om
        // asinkrono dohvacamo sliku, ali buduci da se celije reuse-aju moguce je dobiti pogresne slike na celiji ovisno koliko brzo stizu odgovori sa servera
        //        URLSession.shared.dataTask(with: review.imageUrl!) { (data, response, error) in
        //            let image = UIImage(data: data!)
        //            DispatchQueue.main.async {
        //                self.reviewImageView.image = image
        //            }
        //            print(image)
        //        }.resume()
        
        imageService.fetchQuizImage(ulrString: quiz.imageUrl){ (image) in
            print("setting image")
            DispatchQueue.main.async {
                self.quizImage.image = image
                self.quizImage.isHidden = false
            }
            print("image set")
        }
        
        
        // Postavljanje slike tako da odmah stvorimo sinkrono UIImage iz url-a
        // lose jer blokira glavnu dretvu na kojoj se treba izvoditi samo UI
        //        let data = try? Data(contentsOf: review.imageUrl!)
        //
        //        if let imageData = data {
        //            let image = UIImage(data: imageData)
        //            reviewImageView.image = image
        //        }
        //
        
        
        // koristimo kingfisher za ispravno rukovanje slikama
//        if
//            let url = review.imageUrl {
//            reviewImageView.kf.setImage(with: url)
//        }
    }
}
