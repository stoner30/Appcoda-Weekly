//
//  ViewController.swift
//  SlotMachine
//
//  Created by Stoner Wang on 15/11/2.
//  Copyright © 2015年 Nuces Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageArray = [ "🍎", "😍", "🐮", "🐼", "🐔", "🎅", "🚍", "💖", "👑", "👻" ]
        
        for var i = 0; i < 100; i++ {
            dataArray1.append((Int) (arc4random() % 10))
            dataArray2.append((Int) (arc4random() % 10))
            dataArray3.append((Int) (arc4random() % 10))
        }
        
        resultLabel.text = ""
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
        pickerView.selectRow(Int(arc4random()) % 94 + 3, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random()) % 94 + 3, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random()) % 94 + 3, inComponent: 2, animated: true)
        
        if dataArray1[pickerView.selectedRowInComponent(0)] == dataArray2[pickerView.selectedRowInComponent(1)] && dataArray2[pickerView.selectedRowInComponent(1)] == dataArray3[pickerView.selectedRowInComponent(2)] {
            resultLabel.text = "Bingo!!"
        } else {
            resultLabel.text = ""
        }
    }
    
    // MARK: - PickerView Data Source
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // MARK: - PickerView Delegate
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        if component == 0 {
            pickerLabel.text = imageArray[dataArray1[row]]
        } else if component == 1 {
            pickerLabel.text = imageArray[dataArray2[row]]
        } else {
            pickerLabel.text = imageArray[dataArray3[row]]
        }
        
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 80)
        pickerLabel.textAlignment = NSTextAlignment.Center
        
        return pickerLabel
    }

}

