//
//  UIView+Size.swift
//  YFRefresh
//
//  Created by YangFan on 2017/5/2.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    var yfContentOffSetY: Double
    {
        set {
            contentOffset.y = CGFloat(yfContentOffSetY)
        }
        get {
            return Double(contentOffset.y)
        }
    }
}
