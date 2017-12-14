//
//  HomeViewController.swift
//  ISS_Space_App
//
//  Created by redEyeProgrammer on 12/13/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()
    var longitudeLocation: String?
    var latitudeLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            guard let locationManager = locManager.location else { return }
            currentLocation = locationManager
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtLatitude.text = ""
        txtLongitude.text = ""
    }
    
    @IBAction func currentLocationButton(_ sender: Any) {
        if locManager.location != nil {
            
            setValuesforLocation(long: String(currentLocation.coordinate.longitude), lat: String(currentLocation.coordinate.latitude))
            performSegue(withIdentifier: "stationTableSegue", sender: nil)
        } else {
            showToastWith(title: "ALert!", message: "Current Location Is Disabled", withAction: nil)
        }
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        if (txtLongitude.text?.isEmpty)! || (txtLatitude.text?.isEmpty)! {
            showToastWith(title: "Alert!", message: "All Textfields must have value", withAction: nil)
            
        } else {
            setValuesforLocation(long: txtLongitude.text!, lat: txtLatitude.text!)
            performSegue(withIdentifier: "stationTableSegue", sender: nil)
        }
    }
    
    func setValuesforLocation(long: String, lat: String) {
        longitudeLocation = long
        latitudeLocation = lat
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tableViewController = segue.destination as? StationsTableViewController else { return }
        if segue.identifier == "stationTableSegue" {
            tableViewController.longitude = longitudeLocation
            tableViewController.latitude = latitudeLocation
            
        }
    }
    
    //Unwind Segue
    @IBAction func unwindToHomeVC(segue:UIStoryboardSegue) {
        
    }
}


extension HomeViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
    }
}
