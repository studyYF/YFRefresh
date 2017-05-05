//
//  BaseLayer.swift
//  YFRefresh
//
//  Created by YangFan on 2017/5/5.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import Foundation
import UIKit

class BaseLayer: CALayer {
    
    //MARK: 定义属性
    var arrawLayer: ArrowLayer?
    
    var circleLayer: CircleLayer?
    
    var checkLayer: CheckLayer?
    
    init(frame: CGRect) {
        super.init()
        self.frame = frame
        initLayer()
        arrawLayer?.completionAnimation = { 
            self.circleLayer?.pointAnimation()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///初始化各个图层模块
    func initLayer() {
        arrawLayer = ArrowLayer(frame: bounds)
        addSublayer(arrawLayer!)
        circleLayer = CircleLayer(frame: bounds)
        addSublayer(circleLayer!)
        checkLayer = CheckLayer(frame: bounds)
        addSublayer(checkLayer!)
    }
    
    ///开始刷新
    func startRefresh() {
        arrawLayer?.startAnimation()
    }
    
    /// 结束刷新
    func stopRefresh(_ completion: @escaping () -> ()) {
        circleLayer?.stopPointAnimation()
        checkLayer?.checkAnimation()
        checkLayer?.completion = {
            completion()
            self.arrawLayer?.endAnimation()
            self.circleLayer?.recoverLayer()
            self.checkLayer?.recoverlayer()
        }
    }
}
