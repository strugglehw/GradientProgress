//
//  ViewController.swift
//  GradientProgress
//
//  Created by atao on 01/21/2025.
//  Copyright (c) 2025 atao. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import GradientProgress

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gpView = GradientProgressView();
        //默认是黑色，结合要用的情景设置背景
//        gpView.backgroundColor = UIColor.white
        gpView.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(gpView);
        gpView.snp_makeConstraints { make in
            make.center.equalTo(view)
            make.width.height.equalTo(100)
        }
        //设置渐变的方向
        gpView.gradientStart = .leftTop
        //设置渐变的颜色组
        gpView.gradientColors = [UIColor.yellow,UIColor.blue,UIColor.red];
        
        let button = UIButton(type: .custom)
        button.setTitle("start", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        view.addSubview(button)
        button.snp_makeConstraints { make in
            make.top.equalTo(gpView.snp_bottom).offset(20)
            make.centerX.equalTo(view)
        }
        button.rx.controlEvent(.touchUpInside).subscribe(onNext: {
            gpView.setProgress(50,animation: true);
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

