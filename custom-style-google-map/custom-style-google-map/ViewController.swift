//
//  ViewController.swift
//  custom-style-google-map
//
//  Created by Rodrigo Cavalcante on 11/01/17.
//  Copyright © 2017 Rodrigo Cavalcante. All rights reserved.
//

import UIKit
import GoogleMaps

extension GMSMapView {
    func mapStyle(withFilename name: String, andType type: String) {
        do {
            if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    let lat = -1.4503799
    let long = -48.4761371
    let zoom: Float = 13
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createMapView()
        addMarker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createMapView() {
        let camera = GMSCameraPosition.camera(withLatitude:lat,
                                              longitude: long, zoom: zoom)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
    }

    func addMarker() {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long)
        marker.title = "Belém"
        marker.snippet = "Pará"
        marker.map = mapView
    }
    
    @IBAction func changeMapStyle(_ button: UIButton) {
        if let title = button.currentTitle {
            self.mapView.mapStyle(withFilename: title, andType: "json")
        }
    }
}

