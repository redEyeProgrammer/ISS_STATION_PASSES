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
//    public let altitude:  Int?
//    public let dateTime:  Int?
//    public let passes:    Int?
//    public let latitude:  Int?
//    public let longitude: Int?
    
    
    func getTimeFormatted(seconds: Int) -> String {
        return self.formatter.string(from: TimeInterval(seconds))!
    }
    
    public init(station : Stations) {
        self.duration = station.duration
        self.riseTime = station.risetime
//        self.altitude = station.altitude
//        self.dateTime = station.dateTime
//        self.passes = station.passes
//        self.latitude = station.latitude
//        self.longitude = station.longitude
        
    }
    

    
}


extension StationViewModel {
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
