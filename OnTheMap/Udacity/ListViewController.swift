//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-06-02.
//  Copyright © 2018 truBrain. All rights reserved.
//
import UIKit

class ListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logout: UIBarButtonItem!
    @IBOutlet weak var pin: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var cell: UITableViewCell!
    
    
    @IBAction func pinbuttonaction(_ sender: AnyObject) {
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "pintoInfo", sender: self)
        })
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let maplocation = StudentData.sharedInstance().mappoints[(indexPath.row)]
        cell.textLabel?.text = maplocation.fullname
        cell.imageView?.image = UIImage(named: "pinB")
        return cell
        
    }
    
    
}
