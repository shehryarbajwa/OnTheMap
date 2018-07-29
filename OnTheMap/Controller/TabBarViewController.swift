//
//  TabBarViewController.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-26.
//  Copyright © 2018 truBrain. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadstudentinformation), name: .reload, object: nil)
        loadstudentinformation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBOutlet weak var logout : UIBarItem?
    @IBOutlet weak var addpin : UIBarItem?
    @IBOutlet weak var refresh : UIBarItem?
    
    @IBAction func logoutsession(_ sender: Any){
        UdacityClient.sharedInstance().sessionLogout { (success, errorString) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.alert(title: "Error logging out", message: errorString!)
            }
        }
    }
    
    @IBAction func reload(_ sender: Any){
        loadstudentinformation()
    }
    
    @objc private func loadstudentinformation() {
        ParseClient.sharedInstance().getmultiplelocations { (StudentInformation, error) in
            if let error = error {
                self.alert(title: "Error", message: error.localizedDescription)
                return
        }
            if let StudentInformation = StudentInformation {
               ParseStudent.StudentStorage.studentsInformation = StudentInformation
               NotificationCenter.default.post(name: .reloadCompleted, object: nil)
            }
        }
    }
    
    @IBAction func addLocation(_ sender: Any){
        enablebuttons(false)
        ParseClient.sharedInstance().getsingleLocation { (studentInformation, error) in
            if let error = error {
                self.alert(title: "Error", message: error.localizedDescription)
            }
            else if let studentInformation = studentInformation {
                
                let msg = "User \"\(studentInformation.firstName)\" has already posted a Student Location. Would you like to Overwrite it?"
                self.overrideconfirmation(title: "Override", message: msg, action: {
                    //self.showpostingView()
                })
            } else {
                //performUIUpdatesOnMain {
                    //self.showpostingView()
                }
                
                self.enablebuttons(true)
            }
        }
    
    
    private func enablebuttons(_ enable:Bool){
        performUIUpdatesOnMain {
            self.logout?.isEnabled = enable
            self.addpin?.isEnabled = enable
            self.refresh?.isEnabled = enable
        }
    }
    
    private func showpostingView(studentObjectID:String){
        //let postingView = storyboard?.instantiateViewController(withIdentifier: "postingView") as! PostingView
        //postingView.locationID = studentObjectID
       // navigationController?.pushViewController(postingView, animated: true)
    }
    
    
    
    
    
    
    
    
 

}
