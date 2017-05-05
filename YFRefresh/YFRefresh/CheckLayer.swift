//
//  CheckLayer.swift
//  YFRefresh
//
//  Created by YangFan on 2017/5/5.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import Foundation
import UIKit

class CheckLayer: CALayer,CAAnimationDelegate {
    
    var checkLayer = CAShapeLayer()
    
    var completion: (() ->())?
    
    init(frame: CGRect) {
        super.init()
        self.frame = frame
        backgroundColor = UIColor.clear.cgColor
        initCheck()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    ///绘制对号
    func initCheck() {
        let width = frame.size.width
        let height = frame.size.height
        let path = UIBezierPath()
        path.move(to: .init(x: width / 2 - width / 5, y: height / 2))
        path.addLine(to: .init(x: width / 2, y: height / 2 + height / 8))
        path.addLine(to: .init(x: width / 2 + width / 4, y: height / 2 - height / 6))
        checkLayer.strokeStart = 0
        checkLayer.strokeEnd = 0
        checkLayer.lineWidth = 2
        checkLayer.fillColor = UIColor.clear.cgColor
        checkLayer.strokeColor = UIColor.lightGray.cgColor
        checkLayer.lineCap = kCALineCapRound
        checkLayer.path = path.cgPath
        addSublayer(checkLayer)
    }
    
    
    /// 对号的动画
    func checkAnimation() {
        let start = CAKeyframeAnimation(keyPath: "strokeStart")
        start.values = [0, 0, 0]
        start.duration = 0.5
        start.isRemovedOnCompletion = false
        start.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        start.fillMode = kCAFillModeForwards
        checkLayer.add(start, forKey: "strokeStart")
        
        let end = CAKeyframeAnimation(keyPath: "strokeEnd")
        end.values = [0, 1, 1]
        end.duration = 0.8
        end.isRemovedOnCompletion = false
        end.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        end.fillMode = kCAFillModeForwards
        end.delegate = self
        checkLayer.add(end, forKey: "strokeEnd")

    }
    
    func recoverlayer() {
        checkLayer.strokeStart = 0
        checkLayer.strokeEnd = 0
        checkLayer.removeAllAnimations()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.completion?()
    }
    
    
}
