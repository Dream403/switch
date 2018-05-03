//
//  ViewController.swift
//  SwitchDemo
//
//  Created by snowlu on 2018/4/26.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let swichtOnView   = ZLSwitchView.init(frame: CGRect.init(x: 10, y: 60, width: 60, height: 40));
        swichtOnView.isOn = true;
        self.view.addSubview(swichtOnView);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

