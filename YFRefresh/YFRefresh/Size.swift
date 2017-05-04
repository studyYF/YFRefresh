//
//  Size.swift
//  Suyuan-swift
//
//  Created by YangFan on 16/12/16.
//  Copyright © 2016年 YangFan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    ///控件的宽
    var yfWidth : CGFloat {
        set {
           frame.size.width = yfWidth
        }
        get {
             return frame.size.width
        }
    }
    ///控件的高
    var yfHeight : CGFloat {
        set {
            frame.size.height = yfHeight
        }
        get {
            return frame.size.height
        }
    }
    
    ///控件的x
    var yfX : CGFloat {
        set {
            frame.origin.x = yfX
        }
        get {
            return frame.origin.x
        }
    }
    
    ///控件的y
    var yfY : CGFloat {
        set {
            frame.origin.y = yfY
        }
        get {
            return frame.origin.y
        }
    }
    
    ///控件的centerX
    var yfCenterX : CGFloat {
        set {
            center.x = yfCenterX
        }
        get {
            return center.x
        }
    }
    
    ///控件的centerY
    var yfCenterY : CGFloat {
        set {
            center.y = yfCenterY
        }
        get {
            return center.y
        }
    }
    
    
}
