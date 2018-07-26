//
//  LoginViewController.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-12.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    
    
    var activityIndicator = UIActivityIndicatorView()
    var keyboardscreen = false
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var debugTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func userpressedlogin(_ sender:Any){
        if testtextfield(){
            print("Please login with your udacity credentials")
            //Add an alert view here
        } else {
            UdacityClient.sharedInstance().authenticateWithLogin((usernameTextfield.text)!, (passwordTextfield.text)!) { (success, errorString ) in
                performUIUpdatesOnMain{
                    if success{
                        self.completelogin()
                    } else {
                        print("Your request couldn't be completed")
                        //replace this with an alert view here
                    }
                    
            }
                
        }
        }
        
    }
    
    @IBAction func signup(_ sender: Any){
        let urlString = "https://www.udacity.com/account/auth#!/signup"
        let url = URL(string: urlString)
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    
    private func completelogin(){
        let controller = storyboard?.instantiateViewController(withIdentifier: "NavigationMainViewController") as! UINavigationController
        present(controller, animated: true, completion: nil)
    }
    
    private func testtextfield() -> Bool {
        if usernameTextfield.text!.isEmpty || passwordTextfield.text!.isEmpty{
            return true
        }
        else{
            return false
        }
    }
    
    
    func textfieldshouldreturn(textfield:UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
    
    func keyboardwillshow(notification: Notification){
        if !keyboardscreen{
            view.frame.origin.y -= keyboardheight(notification: notification)
        }
    }
    
    func keyboarddidshow(notification:Notification){
        keyboardscreen = true
    }
    
    func keyboardwillhide(notification:Notification){
        keyboardscreen = false
    }
    
    func keyboardheight(notification:Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}




