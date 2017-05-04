//
//  ViewController.swift
//  YFRefresh
//
//  Created by YangFan on 2017/4/28.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YFRefresh"
        navigationController?.navigationBar.barTintColor = UIColor.cyan
        navigationController?.navigationBar.isTranslucent = false
        
        tableview.frame = view.bounds
        tableview.delegate = self
        tableview.dataSource = self
        tableview.addHeaderView {
            self.refresh()
        }
//        tableview.yfHeader = YFRefreshHeader.init(target: self, action: #selector(ViewController.refresh))
        view.addSubview(tableview)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "测试"
        return cell
    }
}

extension ViewController {
    @objc fileprivate func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.tableview.yfHeader.endRefreshing()
        })
    }
}
