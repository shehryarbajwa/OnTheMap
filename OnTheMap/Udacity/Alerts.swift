//
//  Alerts.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-06-03.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation
import UIKit

class AlertVC: UIViewController {
    
    static let shareVC = AlertVC()
    
    func appalerts(controller: UIViewController, titletext:String, messagestring:String) {
        
        let alert = UIAlertController(title: titletext, message: messagestring, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: {(action) in
        
        alert.dismiss(animated: true, completion: nil)
    }))
    
    self.present(alert, animated: true, completion: nil)
    
}
}



