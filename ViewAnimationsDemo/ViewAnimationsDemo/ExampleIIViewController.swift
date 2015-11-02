//
//  ExampleIIViewController.swift
//  ViewAnimationsDemo
//
//  Created by Stoner Wang on 15/9/7.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class ExampleIIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let firstImageView = UIImageView(image: UIImage(named: "bg01"))
        firstImageView.contentMode = UIViewContentMode.ScaleAspectFill
        firstImageView.frame = view.frame
        view.addSubview(firstImageView)
        
        imageFadeIn(firstImageView)
    }
    
    func imageFadeIn(imageView: UIImageView) {
        let secondImageView = UIImageView(image: UIImage(named: "bg02"))
        secondImageView.contentMode = UIViewContentMode.ScaleAspectFill
        secondImageView.frame = view.frame
        secondImageView.alpha = 0.0
        
        view.insertSubview(secondImageView, aboveSubview: imageView)
        
        UIView.animateWithDuration(2.0, delay: 2.0, options: .CurveEaseOut, animations: {
            secondImageView.alpha = 1.0
        }, completion: {
            _ in
            imageView.image = secondImageView.image
            secondImageView.removeFromSuperview()
        })
    }

}
