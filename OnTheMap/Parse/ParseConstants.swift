//
//  ParseConstants.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-09.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

class ParseAPI {
    
    struct Applicationdata {
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
    struct Methods {
        static let StudentLocation = "/StudentLocation"
        static let Objectidentity = "StudentLocation/<objectId>"
    }
    
    struct URLParameters {
        static let APIHost = "parse.udacity.com"
        static let APIScheme = "https://"
        static let APIPath = "parse/classes"
    }
    
    struct QueryKeys {
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
        static let Where = "where"
        static let SessionID = "sessionID"
        static let RequestToken = "request_token"
    }
    
    struct ParseApplicationKeys {
        static let parseApplicationID = "X-Parse-Application-Id"
        static let parseAPIKey = "X-Parse-REST-API-Key"
    }
    
    struct JSONResponseKeys {
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let userID =  "userid"
        static let mediaURL = "mediaurl"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let mapString = "mapString"
        static let objectID = "objectID"
        static let StudentLocation = "results"
        static let updatedAt = "recentlocation"
    }
    
    
    
    
    
    
    
}
