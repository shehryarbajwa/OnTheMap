//
//  ViewController.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-05-28.
//  Copyright © 2018 truBrain. All rights reserved.
//
import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var debug: UITextView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    
    var alerts : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.stopAnimating()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.activityView.stopAnimating()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
    }
    
    
    
    func loginComplete(){
        // If the login details are accurate, then present the next VC
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "seguetotabbar", sender: nil)
        })
    }
    
    func checkfortext()-> Bool {
        
        //This checks whether the text fields are empty and the user hasn't entered anything yet
        //Then display text in the debug window
        //Then alert the user that please enter something
        //finish executing
        
        if (emailField.text == "" || emailField.text == "email" || passwordField.text == "" || passwordField.text == "password"){
            checkerror("Please enter a username or password")
            let alert = UIAlertController(title: "Couldn't verify your credentials", message: "Please provide your username or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil) )
            self.present(alert, animated: true, completion: nil)
            activityView.stopAnimating()
            return true
        }
        else{
            return false
        }
    }
    //texttodisplay displays the errorString on the debug window
    func checkerror(_ errorString: String?){
        DispatchQueue.main.async(execute: {
            if let errorString = errorString {
                self.debug.text = errorString
                self.LoginButton.isEnabled = true
            }
        })
    }
    
    @IBAction func udacitysignup(_ sender: Any){
        
        //When the udacity sign up button is clicked, it should lead to Udacity's sign up page
        UIApplication.shared.open(URL(string: "https://www.udacity.com/account/auth#!/signup")!, options: [:], completionHandler: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
