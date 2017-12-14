//
//  DetailsViewController.swift
//  ISS_Space_App
//
//  Created by redEyeProgrammer on 12/14/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var lblPasses: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
  
    var requestDict: [String : Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
    }
    

    func loadDetails() {
        let stationDetailModel = StationDetailModel(station: requestDict!)
        stationDetailModel.configureDetails(self as StationViewModelView)
    }
    
    
    @IBAction func homeScreenButton(_ sender: Any) {
    }
}
