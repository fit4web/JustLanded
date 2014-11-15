//
//  ViewController.swift
//  JustLanded
//
//  Created by Noah Ludescher on 15.11.14.
//  Copyright (c) 2014 Fit4web. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func fBLogin(){
        let loginview:FBLoginView = FBLoginView()
        loginview.center = self.view.center
        self.view .addSubview(loginview)
    }
}

