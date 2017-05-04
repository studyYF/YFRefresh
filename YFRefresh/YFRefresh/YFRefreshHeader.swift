//
//  YFRefreshHeader.swift
//  YFRefresh
//
//  Created by YangFan on 2017/4/28.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit


/// 刷新控件高度
private let headerHeight: CGFloat = 54.0

/// 下拉刷新状态
///
/// - YFRefreshHeaderStateNormal: 正常状态
/// - YFRefreshHeaderStatePulling: 松开就可以进行刷新的状态
/// - YFRefreshHeaderStateRefreshing: 正在刷新
/// - YFRefreshHeaderStateWillRefresh: 即将刷新
enum YFRefreshHeaderState {
    case Normal
    case Pulling
    case Refreshing
    case WillRefresh
}




class YFRefreshHeader: UIView {
    
    var state: YFRefreshHeaderState? = .Normal {
        didSet {
            setState(state!)
        }
    }
    
    var actionBlock: (() -> ()?)? = nil
    
    var target: Any?
    
    var action: Selector?
    
    var scrollViewOriginInset: UIEdgeInsets = .zero
    
    var scrollView: UIScrollView? = nil
    
    ///结束刷新
    public func endRefreshing() {
        state = .Normal
    }
    ///开始刷新
    public func beginingRefreshing() {
        state = .Refreshing
    }
    
    var label: UILabel? = {
        let label = UILabel(frame: CGRect(x: 30, y: -50, width: 100, height: 40))
        label.text = "你好"
        return label
    }()
    
    convenience init(target: Any, action:Selector) {
        self.init(frame: .zero)
        //设置自动调整与父控件的位置关系
        autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin]
//        self.backgroundColor = UIColor.blue
        self.target = target
        self.action = action
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin]
        setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 通知接受者他的父视图将会改变成新的视图
    ///
    /// - Parameter newSuperview: 传进来的tableView或者collectionView
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        //移除旧的监听
        superview?.removeObserver(self, forKeyPath: kYFRefreshContentOffset, context: nil)
        //添加新的监听
        if let newSuperview = newSuperview as? UIScrollView {
            newSuperview.addObserver(self, forKeyPath: kYFRefreshContentOffset, options: .new, context: nil)
            //赋值
            scrollView = newSuperview
            //设置位置
            scrollViewOriginInset = newSuperview.contentInset
            //设置支持垂直弹性效果
            scrollView?.alwaysBounceVertical = true
        }
    }
    
    
    //监听数据变化 scrollView的contentOffset
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //判断是否需要调整contentOffset
        if (!isUserInteractionEnabled || alpha <= 0.01 || isHidden || state == .Refreshing)  {
            return
        }
        
        if keyPath == kYFRefreshContentOffset {
            adjustOffset()
        }
    }
    
    
    /// 调整scrollView的contentOffset
    func adjustOffset() {
        
        if state != .Refreshing {
            scrollViewOriginInset = (scrollView?.contentInset)!
        }
        ///如果正在刷新，则返回
        if state == .Refreshing {
            return
        }
        ///当前的offset
        let currentOffsetY = (scrollView?.yfContentOffSetY)!
        ///头部控件刚好出现的contentOffsetY
        let visibleContentOffsetY = Double(-scrollViewOriginInset.top)
        
        //如果是向上滚动，则看不见刷新控件，直接返回
        if currentOffsetY >= visibleContentOffsetY { return }
        
        ///即将刷新的临界点
        let imidateRefreshOffsetY: Double = -Double(headerHeight)
        
        if (scrollView?.isDragging)! {
            //如果小于临界点，正在下拉
            if currentOffsetY > imidateRefreshOffsetY && state == .Normal {
                //转为正在下拉的状态
                state = .Pulling
            } else if currentOffsetY <= imidateRefreshOffsetY && state == .Pulling{
                //即将刷新
                state = .WillRefresh
            }
            //手松开，并且是即将刷新的状态
        }  else if state == .WillRefresh {
            state = .Refreshing
        }
    }
}

extension YFRefreshHeader {
    fileprivate func setUI() {
        
        
        addSubview(label!)
    }
    fileprivate func setState(_ state: YFRefreshHeaderState) {
        switch state {
        case .WillRefresh:
            label?.text = "松开刷新"
        case .Refreshing:
            label?.text = "正在刷新..."
            scrollView?.setContentOffset(CGPoint(x: 0, y: -headerHeight), animated: true)
            actionBlock!()
        case .Pulling:
            label?.text = "正在下拉"
        default:
            label?.text = "正常状态"
            scrollView?.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
}
