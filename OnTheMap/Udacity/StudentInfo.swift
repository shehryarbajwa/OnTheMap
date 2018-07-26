//
//  StudentData.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-06-01.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

struct StudentInformation{
    var firstname = ""
    var lastname = ""
    var fullname = ""
    var longitude = 0.0
    var latitude = 0.0
    var mediaURL = ""
    var mapString = ""
    
    init(dictionary: [String : AnyObject]){
        if let first = dictionary["first_name"] as? String {
            firstname = first
        }
        if let last = dictionary["last_name"] as? String {
            lastname = last
        }
        fullname = firstname + " " + lastname
        
        if let long = dictionary["longitude"] as? Double {
            longitude = long
        }
        if let lat = dictionary["latitude"] as? Double {
            latitude = lat
        }
        if let media = dictionary["mediaURL"] as? String {
            mediaURL = media
        }
        if let map = dictionary["mapString"] as? String {
            mapString = map
        }
    }
}
