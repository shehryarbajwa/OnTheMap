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
<<<<<<< HEAD
            self.alert(title: "Please login with your udacity credentials", message: "")
        }
        
        UdacityClient.sharedInstance().authenticateWithLogin(email:usernameTextfield.text!, password: passwordTextfield.text!) { (error) in
                if let error = error {
                    self.alert(title: "Invalid Login credentials", message: "Try again")
=======
            self.alert(title: "Please login with your udacity credentials", message: "Please proceed with your credentials")
        } else {
            UdacityClient.sharedInstance().authenticateWithLogin(usernameTextfield.text!, passwordTextfield.text!) { (success, errorString) in
                if success{
                self.performUIUpdatesOnMain {
                    self.performSegue(withIdentifier: "logintotabbar", sender: self)
>>>>>>> d08f80a6d929bd36bc6960d4bc357f0e39302b42
                }
                else {
                    self.completelogin()
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
<<<<<<< HEAD
        self.activityIndicator.startAnimating()
        let controller = storyboard?.instantiateViewController(withIdentifier: "NavigationMainViewController") as! UINavigationController
        self.present(controller, animated: true, completion: nil)
=======
        self.performSegue(withIdentifier: "logintotabbar", sender: self)
>>>>>>> d08f80a6d929bd36bc6960d4bc357f0e39302b42
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




