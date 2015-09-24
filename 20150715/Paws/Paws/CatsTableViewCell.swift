//
//  CatsTableViewCell.swift
//  Paws
//
//  Created by Stoner Wang on 15/9/24.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class CatsTableViewCell: PFTableViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catVotesLabel: UILabel!
    @IBOutlet weak var catCreditLabel: UILabel!
    @IBOutlet weak var catPawIcon: UIImageView!
    
    override func awakeFromNib() {
        let guesture = UITapGestureRecognizer(target: self, action: "onDoubleTap:")
        guesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(guesture)
        
        catPawIcon.hidden = true
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onDoubleTap(sender: AnyObject) {
        catPawIcon.hidden = false
        catPawIcon.alpha = 1.0
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: .TransitionNone, animations: {
            self.catPawIcon.alpha = 0
        }, completion: {
            finished in
            self.catPawIcon.hidden = true
        })
    }
    
}
