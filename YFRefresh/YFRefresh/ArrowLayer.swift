//
//  ArrowLayer.swift
//  YFRefresh
//
//  Created by YangFan on 2017/5/4.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import Foundation
import UIKit

class ArrowLayer: CALayer{
    
    //MARK: 属性
    var verticalLineLayer: CAShapeLayer?
    var arrowLayer: CAShapeLayer?
    var color: UIColor?
    var lineWidth: CGFloat
    
    
    
    init(frame: CGRect, color: UIColor = UIColor.black, lineWidth: CGFloat = 1) {
        self.color      = color
        self.lineWidth  = lineWidth
        super.init()
        self.frame      = frame
        backgroundColor = UIColor.clear.cgColor
        initVerticalLine()
        initArrow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //绘制垂直的线
    private func initVerticalLine() {
        let width = frame.size.width
        let height = frame.size.height
        let path = UIBezierPath()
        path.move(to: .init(x: width / 2, y: 0))
        path.addLine(to: .init(x: width / 2, y: height / 2 + height / 3))
        verticalLineLayer = CAShapeLayer()
        verticalLineLayer?.lineWidth = lineWidth * 2
        verticalLineLayer?.strokeColor = color?.cgColor
        verticalLineLayer?.fillColor = UIColor.clear.cgColor
        verticalLineLayer?.lineCap = kCALineCapRound
        verticalLineLayer?.path = path.cgPath
        verticalLineLayer?.strokeStart = 0.5
        addSublayer(verticalLineLayer!)
    }
    
    /// 绘制箭头
    private func initArrow() {
        let width = frame.size.width
        let height = frame.size.height
        let path = UIBezierPath()
        path.move(to: .init(x: width / 2 - height / 6, y: width / 2 + height / 6))
        path.addLine(to: .init(x: width / 2, y: height / 2 + height / 3))
        path.addLine(to: .init(x: width / 2 + height / 6, y: height / 2 + height / 6 ))
        arrowLayer = CAShapeLayer()
        arrowLayer?.lineWidth = lineWidth * 2
        arrowLayer?.strokeColor = color?.cgColor
        arrowLayer?.fillColor = UIColor.clear.cgColor
        arrowLayer?.lineCap = kCALineCapRound
        arrowLayer?.lineJoin = kCALineJoinRound
        arrowLayer?.path = path.cgPath
        addSublayer(arrowLayer!)
    }
    
    /// 动画,把箭头收回去的动画
    public func startAnimation() {
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.fromValue = 0
        start.toValue = 0.5
        start.duration = 0.5
        start.fillMode = kCAFillModeForwards
        start.isRemovedOnCompletion = false
        start.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        start.delegate = self
        
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 0
        end.fromValue = 0.5
        end.fillMode = kCAFillModeForwards
        end.isRemovedOnCompletion = false
        end.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        arrowLayer?.add(start, forKey: "strokeStart")
        arrowLayer?.add(end, forKey: "strokeEnd")
    }
    
    ///线条的动画往上移动
    fileprivate func lineAnimation() {
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.fromValue = 0.5
        start.toValue = 0
        start.duration = 0.25
        start.fillMode = kCAFillModeForwards
        start.isRemovedOnCompletion = false
        start.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 0.03
        end.fromValue = 1
        end.beginTime = CACurrentMediaTime() + 0.5 / 3
        end.duration = 0.25
        end.fillMode = kCAFillModeForwards
        end.isRemovedOnCompletion = false
        end.delegate = self
        end.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        verticalLineLayer?.add(start, forKey: "strokeStart")
        verticalLineLayer?.add(end, forKey: "strokeEnd")
    }
}

//MARK: 动画结束
extension ArrowLayer: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let anim = anim as? CABasicAnimation {
            if  anim.keyPath == "strokeStart" {
                //箭头动画结束，开启线的动画
                arrowLayer?.isHidden = true
                lineAnimation()
            } else {//所有动画结束
                verticalLineLayer?.isHidden = true
                
            }
        }
    }
}
