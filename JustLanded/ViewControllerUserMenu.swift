//
//  ViewControllerUserMenu.swift
//  JustLanded
//
//  Created by Noah Ludescher on 16.11.14.
//  Copyright (c) 2014 Fit4web. All rights reserved.
//

import UIKit

class ViewControllerUserMenu: UIViewController, PFLogInViewControllerDelegate{

    @IBOutlet weak var begruessungLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.begruessungLabel.text = PFUser.currentUser().username

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutButton(sender: UIButton) {
        PFUser.logOut()
        println("logout")
        self.dismissViewControllerAnimated(true, completion: nil)
        parseLogin()
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
}
