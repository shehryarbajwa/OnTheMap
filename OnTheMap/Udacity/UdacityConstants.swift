//
//  Constants.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-06-01.
//  Copyright © 2018 truBrain. All rights reserved.
//

import Foundation

class UdacityAPI {

struct ApplicationData {
    
    static let ApplicationID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let ApiKey : String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
}

struct Constants {
    
    static let APIScheme  = "https"
    static let ApiHost = "www.udacity.com"
    static let ApiPath = "/api"
}

struct Methods {
    static let session = "/session"
    static let userID = "/users/<user_id>"
}

struct UdacityJSONParameters {
    static let sessionID = "sessionID"
    static let username = "username"
    static let password = "password"
    static let accesstoken = "access_token"
}

struct JSONResponseKeys {
    static let Account = "account"
    static let Registered = "registered"
    static let Key = "key"
    static let Session = "session"
    static let ID = "id"
    static let Expiration = "expiration"
    static let FirstName = "first_name"
    static let LastName = "last_name"
    static let UserInfo = "user"
}

}


