//
//  ViewController.swift
//  JustLanded
//
//  Created by Noah Ludescher on 15.11.14.
//  Copyright (c) 2014 Fit4web. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, FBLoginViewDelegate {

//Labels
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var fBUsername = ""
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)

        if (PFUser.currentUser() != nil) {
            if PFUser.currentUser().valueForKey("Group") == nil {
                println("do nothing")
            }
            else {
                var user:String = PFUser.currentUser().valueForKey("Group") as String
            
                if user == "Admin"{
                    self.performSegueWithIdentifier("AdminStoryboard", sender: self )
                }
                else if user == "User"{
                    self.performSegueWithIdentifier("UserStoryboard", sender: self)
                    
                }
                else {
                    println("else happend")
                }
            
//            var username:String = PFUser.currentUser().valueForKey("firstName") as String
//                username += " "
//                username += PFUser.currentUser().valueForKey("lastName") as String
//                self.welcomeLabel.text = "Hallo \(username) "
//           
            }}
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
    //Delegates------------------------------------------------------------------------------------------------------------------------------
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
       self.dismissViewControllerAnimated(true, completion: nil)
        println("logInViewController-LOGINSUCESS")

        //Jedem neuen Benutzer in die Gruppe USER sowie die FB-Daten hinzugügen, sofern ein FB-Login"
        var me:PFUser = PFUser.currentUser()
        if  me["Group"] == nil {
            me["Group"] = "User"
            //Check if User uses FB for Login
            let isUserLoggedInWithFacebook = PFFacebookUtils.session()
            if isUserLoggedInWithFacebook != nil {
                //FB Connex to fetch all public Details and Copy it to Userdatabase
                let fBConnex = FBRequest.requestForMe()
                fBConnex.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error: NSError!) -> Void in
                    
                    if error != nil {
                        println("error fetching FB username")
                    }
                    else {
                        var tResult = result as NSDictionary
                        println(tResult.objectForKey("picture"))
                        me["facebookId"] = tResult.objectForKey("id") as String
                        me["firstName"] = tResult.objectForKey("first_name") as String
                        me["lastName"] = tResult.objectForKey("last_name") as String
                        me["location"] = tResult.objectForKey("locale") as String
                        me["gender"] = tResult.objectForKey("gender") as String
                        me["fbLink"] = tResult.objectForKey("link") as String
                        
                        me.saveInBackground()
                    }
                }
            }
        }
        else {
            me.saveInBackground()
        }
    
    
        self.navigationController?.popToViewController(ViewControllerUserMenu(), animated: false)
        self.performSegueWithIdentifier("UserStoryboard", sender: self)
    }
    
    func logInViewControllerDidCancelLogIn(controller: PFLogInViewController) -> Void {
        self.dismissViewControllerAnimated(false, completion: nil)
        println("logInViewController-LOGIN WITHOUT SUCESS")
        }
   // ------------------------------------------------------------------------------------------------------------------------------------------
    //FBDelegate

    func loginViewShowingLoggedInUser(loginView: ViewController!) {
        println("loginViewFetchedUserInfo")

    }
    
    func loginViewFetchedUserInfo(loginView: ViewController!, user: FBGraphUser!) {
        println("loginViewShowingLoggedInUser")
        self.fBUsername = user.last_name
    }
  
    
    // -----------------------------------------------------------------------------------------------------------------------------------------
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

