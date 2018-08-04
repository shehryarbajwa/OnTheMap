//
//  MapViewController.swift
//  OnTheMap-Shehryar edit
//
//  Created by Shehryar Bajwa on 2018-07-29.
//  Copyright © 2018 truBrain. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCompleted), name: .reloadCompleted, object: nil)
        
        mapkit.delegate = self as? MKMapViewDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBOutlet weak var mapkit: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @objc func reloadCompleted(){
        performUIUpdatesOnMain {
            self.activityIndicator.stopAnimating()
            self.mapkit.alpha = 0.5
        }
    }
    
    private func showstudentsonthemap(_ studentInformation: [ParseStudent]){
        mapkit.removeAnnotations(mapkit.annotations)
        for info in studentInformation where info.latitude != 0 && info.longitude != 0 {
            let annotation = MKPointAnnotation()
            annotation.title = info.firstName
            annotation.subtitle = info.mediaURL
            annotation.coordinate = CLLocationCoordinate2D(latitude: info.latitude!, longitude: info.longitude!)
            mapkit.addAnnotation(annotation)
        }
        mapkit.showAnnotations(mapkit.annotations, animated: true)
        
    }
    
    
    
    

}
