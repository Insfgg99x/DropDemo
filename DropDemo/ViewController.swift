//
//  ViewController.swift
//  DropDemo
//
//  Created by xgf on 2018/8/9.
//  Copyright © 2018年 xgf. All rights reserved.
//

import UIKit
import SpriteKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private var sence : DropScene?
    private var tbView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        createTableView()
        addDropView()
    }
    private func setup() {
        view.backgroundColor = .white
    }
    private func createTableView() {
        tbView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cid")
        tbView.tableFooterView = UIView.init()
        view.addSubview(tbView)
        var array = [Int]()
        for i in 0 ..< 100 {
            array.append(i)
        }
        Observable.just(array.map {
            "\($0)"
        }).bind(to: tbView.rx.items(cellIdentifier: "cid")) { _, text , cell in
            cell.textLabel?.text = text
        }.disposed(by: disposeBag)
    }
    private func addDropView() {
        let dropView = DropView.init(frame: view.bounds)
        view.addSubview(dropView)
        sence = DropScene.init(size: dropView.frame.size)
        let trasition = SKTransition.reveal(with: .up, duration: 0.2)
        dropView.presentScene(sence!, transition: trasition)
        dropView.backgroundColor = .clear
        sence?.drop()
    }
}
extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sence?.drop()
    }
}
