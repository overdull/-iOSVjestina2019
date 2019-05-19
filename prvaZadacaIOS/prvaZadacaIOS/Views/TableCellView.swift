//
//  TableCellView.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 12/05/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import UIKit

class TableCellView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   
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
        quizDescription.numberOfLines = 30
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
}
