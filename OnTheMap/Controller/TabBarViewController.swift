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
        //NotificationCenter.default.addObserver(self, selector: #selector(loadStudentsInformation), name: .reload, object: nil)
        //loadStudentsInformation()
    }
    
    deinit {
        //NotificationCenter.default.removeObserver(self)
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
    
    private func loadstudentinformation() {
        ParseClient.sharedInstance().getmultiplelocations { (StudentInformation, error) in
            if let error = error {
                self.alert(title: "Error", message: error.localizedDescription)
                return
        }
            if let StudentInformation = StudentInformation {
               ParseStudent.StudentStorage.studentsInformation = StudentInformation
               //NotificationCenter.default.post(name: .reloadCompleted, object: nil)
            }
        }
    }
    
    @IBAction func addLocation(_ sender: Any){
        ParseClient.sharedInstance().getsingleLocation { (location, error) in
            if let error = error {
                self.alert(title: "Error", message: error.localizedDescription)
            }
            else if let location = location {
                let msg = "User \"\(ParseStudent.fullname)\" has already posted a Student Location. Would you like to Overwrite it?"
            }
        }
    }
    
    
 

}
