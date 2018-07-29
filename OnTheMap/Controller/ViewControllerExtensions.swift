//
//  ViewControllerExtensions.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-26.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func alert(title: String, message:String, action: ( ()->Void)? = nil){
        
        performUIUpdatesOnMain {
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertcontroller.addAction(UIAlertAction(title: title, style: .cancel, handler: { (completionhandler) in
            action?()
        }))
        self.present(alertcontroller, animated: true)
    }
    }
    
    func overrideconfirmation(title: String, message:String, action: @escaping ()->Void){
        performUIUpdatesOnMain {
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertcontroller.addAction(UIAlertAction(title: title, style: .default, handler: { (completionhandler) in
            action()
        }))
        self.present(alertcontroller, animated: true)
    }
    }
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    
    func enableUI(views: UIControl..., enable: Bool) {
        performUIUpdatesOnMain {
            for view in views {
                view.isEnabled = enable
            }
        }
    }
    
}
