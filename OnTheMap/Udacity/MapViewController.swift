//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Shehryar Bajwa on 2018-06-02.
//  Copyright © 2018 truBrain. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var NavBar: UINavigationItem!
    @IBOutlet weak var Logout: UIBarButtonItem!
    @IBOutlet weak var pin: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
}
