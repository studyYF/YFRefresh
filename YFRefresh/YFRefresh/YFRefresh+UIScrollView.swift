//
//  YFRefresh+UIScrollView.swift
//  YFRefresh
//
//  Created by YangFan on 2017/4/28.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import Foundation
import UIKit

private var kYFRefreshHeaderKey = "kYFRefreshHeaderKey"

private var kYFRefreshFooterKey = "kYFRefreshFooterKey"

let kYFRefreshContentOffset = "contentOffset"




extension UIScrollView {
    
    
    //增加属性
    
    ///下拉刷新
    var yfHeader: YFRefreshHeader {
        set {
//            if yfHeader != self.yfHeader {
//                self.yfHeader.removeFromSuperview()
                self.willChangeValue(forKey: "yfHeader")
                objc_setAssociatedObject(self, &kYFRefreshHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
                self.didChangeValue(forKey: "yfHeader")
            self.addSubview(yfHeader)
//            }
        }
        get {
            return objc_getAssociatedObject(self, &kYFRefreshHeaderKey) as! YFRefreshHeader
        }
    }
    
    ///上拉加载
    var yfFooter: YFRefreshFooter {
        set {
            objc_setAssociatedObject(self , &kYFRefreshFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            addSubview(yfFooter)
        }
        get {
            return objc_getAssociatedObject(self, &kYFRefreshFooterKey) as! YFRefreshFooter
        }
    }
    
    
    func addHeaderView(action: @escaping () -> ()) {
        let header = YFRefreshHeader()
        self.yfHeader = header
        header.actionBlock = action
    }
}










