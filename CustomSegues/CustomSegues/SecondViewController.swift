//
//  SecondViewController.swift
//  CustomSegues
//
//  Created by Stoner Wang on 15/9/6.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    var message: String!
    
    override func viewDidLoad() {
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showFirstViewController")
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeGestureRecognizer)
        
        lblMessage.text = message
    }
    
    func showFirstViewController() {
        self.performSegueWithIdentifier("idFirstSegueUnwind", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "idFirstSegueUnwind" {
            let firstViewController = segue.destinationViewController as! ViewController
            firstViewController.lblMessage.text = "You just come back from the 2nd VC"
        }
    }
    
}
