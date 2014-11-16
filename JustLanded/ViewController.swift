//
//  ViewController.swift
//  JustLanded
//
//  Created by Noah Ludescher on 15.11.14.
//  Copyright (c) 2014 Fit4web. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

//Labels
    @IBOutlet weak var welcomeLabel: UILabel!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        if (PFUser.currentUser() != nil) {
            var user:String = PFUser.currentUser().valueForKey("Group") as String
                if user == "Admin"{
                    self.performSegueWithIdentifier("UserStoryboard", sender: self )
                }
                else if user == "User"{
                    self.performSegueWithIdentifier("AdminStoryboard", sender: self)
                }
                else {
                    println("else happend")
            }
            
            
            //    self.welcomeLabel.text = "Hallo \(user)"
           

            
        }
        else{
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


    func parseLogin(){
     var logInController = PFLogInViewController()
       logInController.delegate = self
       logInController.fields = PFLogInFields.UsernameAndPassword
            | PFLogInFields.LogInButton
            | PFLogInFields.SignUpButton
            | PFLogInFields.PasswordForgotten
            | PFLogInFields.DismissButton
            | PFLogInFields.Facebook
            | PFLogInFields.Twitter

        self.presentViewController(logInController, animated:false, completion: nil)
        
        
        
    }
    //Delegates
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
       self.dismissViewControllerAnimated(true, completion: nil)
        println("logInViewController-LOGINSUCESS")
        self.navigationController?.popToViewController(ViewControllerUserMenu(), animated: false)
        self.performSegueWithIdentifier("UserStoryboard", sender: self)
    }
    
    func logInViewControllerDidCancelLogIn(controller: PFLogInViewController) -> Void {
        self.dismissViewControllerAnimated(false, completion: nil)
        println("logInViewController-LOGIN WITHOUT SUCESS")

    }
    
    //Actions
    @IBAction func toRedController(sender: UIButton) {
        
        self.performSegueWithIdentifier("UserStoryboard", sender: self )
        
    }
    @IBAction func logoutButton(sender: UIButton) {
        PFUser.logOut()
        println("logout")
        parseLogin()
    }
}

