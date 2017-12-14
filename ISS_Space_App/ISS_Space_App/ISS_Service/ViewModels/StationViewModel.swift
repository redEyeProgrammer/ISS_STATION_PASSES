//
//  StationViewModel.swift
//  ISS_Space_App
//
//  Created by redEyeProgrammer on 12/13/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import Foundation
import UIKit


@objc public protocol StationViewModelView {
    @objc optional var stationDuration: UILabel { get }
    @objc optional var stationRiseTime: UILabel { get }
    @objc optional var stationAltitude: UILabel { get }
    @objc optional var stationDateTime: UILabel { get }
    @objc optional var stationPasses: UILabel { get }
    @objc optional var stationLatitude: UILabel { get }
    @objc optional var stationLongitude: UILabel { get }
}


public final class StationViewModel {
    
    public let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .full
        return formatter
    }()
    
    public let duration:  Int?
    public let riseTime:  Int?
    
    
    
   public func getTimeFormatted(seconds: Int) -> String {
        return self.formatter.string(from: TimeInterval(seconds))!
    }
    
    public init(station : Stations) {
        self.duration = station.duration
        self.riseTime = station.risetime
    }
    
    public func configure(_ view : StationViewModelView) {
        view.stationDuration?.text = getTimeFormatted(seconds: duration!)
        view.stationRiseTime?.text = getTimeFormatted(seconds: riseTime!)
    }
    
}



extension UITableViewCell : StationViewModelView {
    
    public var stationDuration : UILabel {
        return textLabel!
    }
    
    public var stationRiseTime : UILabel {
        return detailTextLabel!
    }
}



public final class StationDetailModel {
    
    
    public let altitude:  Int?
    public let dateTime:  Int?
    public let passes:    Int?
    public let latitude:  Float?
    public let longitude: Float?
    
    
    public init(station : [String : Any]) {
        self.altitude = station["altitude"] as? Int
        self.dateTime = station["datetime"] as? Int
        self.passes = station["passes"] as? Int
        self.latitude = station["latitude"] as? Float
        self.longitude = station["longitude"] as? Float
    }
    
    
    public func configureDetails (_ view : StationViewModelView) {
        view.stationAltitude?.text = "Altitude -----> \(String(describing: altitude!))"
        view.stationDateTime?.text = "DateTime -----> \(String(describing: dateTime!))"
        view.stationPasses?.text = "Passes -----> \(String(describing: passes!))"
        view.stationLatitude?.text = "Latitude -----> \(String(describing: latitude!))"
        view.stationLongitude?.text = "Longitdue -----> \(String(describing: longitude!))"
    }
    
}

extension DetailsViewController : StationViewModelView {
    public var stationAltitude : UILabel {
        return lblAltitude
    }
    
    public var stationDateTime : UILabel {
        return lblDateTime
    }
    
    public var stationPasses : UILabel {
        return lblPasses
    }
    
    public var stationLatitude : UILabel {
        return lblLatitude
    }
    
    public var stationLongitude: UILabel {
        return lblLongitude
    }
}
