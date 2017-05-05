//
//  CircleLayer.swift
//  YFRefresh
//
//  Created by YangFan on 2017/5/4.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import Foundation
import UIKit

class CircleLayer: CALayer {
    
    
    //MARK: 属性
    var circle = CAShapeLayer()
    
    var point = CAShapeLayer()
    
    var pointBack = CALayer()
    
    
    init(frame: CGRect) {
//        pointBack.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        super.init()
        self.frame      = frame
        backgroundColor = UIColor.clear.cgColor
        pointBack.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        
        pointBack.backgroundColor = UIColor.clear.cgColor
//        anchorPoint = CGPoint(x: 1, y: 1)
//        pointBack.backgroundColor = UIColor.clear.cgColor
        
        initPoint()
        initCircle()
        addSublayer(pointBack)
//        addSublayer(pointBack)
//        drawPoint()
//        addCheckLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 绘制圆环
    func initCircle() {
        let width = frame.size.width
        let height = frame.size.height
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: width / 2, y: height / 2), radius: height / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        circle.path = path.cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.lightGray.cgColor
        circle.lineWidth = 2
        circle.lineCap = kCALineCapRound
        addSublayer(circle)
        circle.isHidden = false
    }
    
    ///绘制圆点
    func initPoint() {
        let width = frame.size.width
//        let height = frame.size.height
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: width / 2, y: width / 2), radius: width / 2, startAngle: CGFloat(Double.pi * 1.5), endAngle: CGFloat((Double.pi * 1.5) - 0.1), clockwise: false)
        point.path = path.cgPath
        point.fillColor = UIColor.black.cgColor
        point.strokeColor = UIColor.black.cgColor
        point.anchorPoint = CGPoint(x: 1, y: 1)
        point.lineWidth = 2
        point.lineCap = kCALineCapRound
        pointBack.addSublayer(point)
        pointAnimation()
    }
    
    ///圆点旋转的动画
    func pointAnimation() {
        let ani = CABasicAnimation(keyPath: "transform.rotation")
        ani.toValue = CGFloat.pi * 2
        ani.fromValue = 0
        ani.duration = 0.8
        ani.repeatCount = MAXFLOAT
        ani.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pointBack.add(ani, forKey: "transform.rotation")
    }
}
