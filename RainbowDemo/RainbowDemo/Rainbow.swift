//
//  Rainbow.swift
//  RainbowDemo
//
//  Created by Stoner Wang on 15/11/3.
//  Copyright © 2015年 Nuces Studio. All rights reserved.
//

import UIKit

// 添加@IBDesignable标记，开启在Storyboard中预览的功能
@IBDesignable
class Rainbow: UIView {
    
    // 使用@IBInspectable标记，即可在Storyboard中改变控件的相应属性
    @IBInspectable var firstColor: UIColor = UIColor(red: 37.0 / 255.0, green: 252.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    @IBInspectable var secondColor: UIColor = UIColor(red: 171.0 / 255.0, green: 250.0 / 255.0, blue: 81.0 / 255.0, alpha: 1.0)
    @IBInspectable var thirdColor: UIColor = UIColor(red: 238.0 / 255.0, green: 32.0 / 255.0, blue: 53.0 / 255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        self.addCircle(80, capRadius: 20, color: self.firstColor)
        self.addCircle(150, capRadius: 20, color: self.secondColor)
        self.addCircle(215, capRadius: 20, color: self.thirdColor)
    }
    
    func addCircle(arcRadius: CGFloat, capRadius: CGFloat, color: UIColor) {
        let x = CGRectGetMidX(self.bounds)
        let y = CGRectGetMidY(self.bounds)
        
        let pathBottom = UIBezierPath(ovalInRect: CGRectMake(x - arcRadius / 2, y - arcRadius / 2, arcRadius, arcRadius)).CGPath
        self.addOval(20.0, path: pathBottom, strokeStart: 0, strokeEnd: 0.5, strokeColor: color, fillColor: UIColor.clearColor(), shadowRadius: 0, shadowOpacity: 0, shadowOffset: CGSizeZero)
        
        let pathMiddle = UIBezierPath(ovalInRect: CGRectMake(x - capRadius / 2 - arcRadius / 2, y - capRadius / 2, capRadius, capRadius)).CGPath
        self.addOval(0.0, path: pathMiddle, strokeStart: 0, strokeEnd: 1.0, strokeColor: color, fillColor: color, shadowRadius: 5.0, shadowOpacity: 0.5, shadowOffset: CGSizeZero)
        
        let pathTop = UIBezierPath(ovalInRect: CGRectMake(x - arcRadius / 2, y - arcRadius / 2, arcRadius, arcRadius)).CGPath
        self.addOval(20.0, path: pathTop, strokeStart: 0.5, strokeEnd: 1.0, strokeColor: color, fillColor: UIColor.clearColor(), shadowRadius: 0, shadowOpacity: 0, shadowOffset: CGSizeZero)
    }
    
    func addOval(lineWidth: CGFloat, path: CGPathRef, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffset: CGSize) {
        let arc = CAShapeLayer()
        arc.lineWidth = lineWidth
        arc.path = path
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = strokeColor.CGColor
        arc.fillColor = fillColor.CGColor
        arc.shadowColor = UIColor.blueColor().CGColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffset
        layer.addSublayer(arc)
    }
    
}
