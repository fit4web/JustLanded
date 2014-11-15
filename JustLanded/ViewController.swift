//
//  ViewController.swift
//  JustLanded
//
//  Created by Noah Ludescher on 15.11.14.
//  Copyright (c) 2014 Fit4web. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    var logInController = PFLogInViewController()


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() != nil) {
           println(PFUser.currentUser())
        }
        else{
        println("else")
        parseLogin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var logInController = PFLogInViewController()
//        logInController.delegate = self
//        self.presentViewController(logInController, animated:true, completion: nil)
        
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
    
    func parseLogin(){
     //   var logInController = PFLogInViewController()
      self.logInController.delegate = self
       self.logInController.fields = PFLogInFields.UsernameAndPassword
            | PFLogInFields.LogInButton
            | PFLogInFields.SignUpButton
            | PFLogInFields.PasswordForgotten
            | PFLogInFields.DismissButton
            | PFLogInFields.Facebook
            | PFLogInFields.Twitter

        self.presentViewController(logInController, animated:true, completion: nil)
        
        
        
    }
    
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
        println("logInViewController-LOGINSUCESS")
        //self.viewDidAppear(true)
    }
    
    func logInViewControllerDidCancelLogIn(controller: PFLogInViewController) -> Void {
        self.dismissViewControllerAnimated(false, completion: nil)
        println("logInViewController-LOGIN WITHOUT SUCESS")

    }
    @IBAction func logoutButton(sender: UIButton) {
        PFUser.logOut()
        println("logout")
        parseLogin()
    }
}

