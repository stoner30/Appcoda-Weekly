//
//  ViewController.swift
//  PullRefresh
//
//  Created by Stoner Wang on 15/11/2.
//  Copyright © 2015年 Nuces Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let dataArray: [String] = [ "One", "Two", "Three", "Four", "Five" ]
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var customView: UIView!
    var labelsArray: [UILabel] = []
    
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.tintColor = UIColor.clearColor()
        tableView.addSubview(refreshControl)
        
        loadCustomRefreshContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadCustomRefreshContents() {
        let refreshContents = NSBundle.mainBundle().loadNibNamed("RefreshContents", owner: self, options: nil)
        customView = refreshContents[0] as! UIView
        customView.frame = refreshControl.bounds
        
        for var i = 0; i < customView.subviews.count; i++ {
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        refreshControl.addSubview(customView)
    }
    
    func animateRefreshStep1() {
        isAnimating = true
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveLinear, animations: { () -> Void in
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
        }) { (finish) -> Void in
            UIView.animateWithDuration(0.05, delay: 0.0, options: .CurveLinear, animations: { () -> Void in
                self.labelsArray[self.currentLabelIndex].transform = CGAffineTransformIdentity
                self.labelsArray[self.currentLabelIndex].textColor = UIColor.blackColor()
            }, completion: { (finish) -> Void in
                ++self.currentLabelIndex
                
                if self.currentLabelIndex < self.labelsArray.count {
                    self.animateRefreshStep1()
                } else {
                    self.animateRefreshStep2()
                }
            })
        }
    }
    
    func animateRefreshStep2() {
        UIView.animateWithDuration(0.35, delay: 0.00, options: .CurveLinear, animations: { () -> Void in
            for label in self.labelsArray {
                label.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }
        }) { (finish) -> Void in
            if self.refreshControl.refreshing {
                self.currentLabelIndex = 0
                self.animateRefreshStep1()
            } else {
                self.isAnimating = false
                self.currentLabelIndex = 0
                
                for label in self.labelsArray {
                    label.textColor = UIColor.blackColor()
                    label.transform = CGAffineTransformIdentity
                }
            }
        }
    }
    
    func getNextColor() -> UIColor {
        var colorsArray: [UIColor] = [UIColor.magentaColor(), UIColor.brownColor(), UIColor.yellowColor(), UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.orangeColor()]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        ++currentColorIndex
        
        return returnColor
    }
    
    func doSomething() {
        timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "endOfWork", userInfo: nil, repeats: true)
    }
    
    func endOfWork() {
        refreshControl.endRefreshing()
        timer.invalidate()
        timer = nil
    }

    // MARK: - TableView Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    // MARK: - TableView Delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing {
            if !isAnimating {
                doSomething()
                animateRefreshStep1()
            }
        }
    }

}

