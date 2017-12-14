//
//  Stations.swift
//  ISS_Space_App
//
//  Created by redEyeProgrammer on 12/13/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import Foundation



public final class Stations {
    
    
    internal struct Keys {
        //        static let altitude =  "altitude"
        //        static let datetime =  "datetime"
        //        static let latitude =  "latitude"
        //        static let longitude = "longitude"
        //        static let passes =    "passes"
        static let duration =  "duration"
        static let risetime =  "risetime"
        
    }
    
    // MARK: - Instance Properties
    public let duration: Int?
    public let risetime: Int?
    
    
    // MARK: - Object Lifecycle
    public init?(json: [String: Any]) {
        
        guard let duration = json[Keys.duration] as? Int,
            let risetime = json[Keys.risetime] as? Int
            else {
                return nil
        }
        self.duration = duration
        self.risetime = risetime
        
        
    }
    
    public class func array(requestDict: [String: Any], responseArray: [[String : Any]]) -> [Stations] {
        var array: [Stations] = []
        for json in responseArray {
            guard let stations = Stations(json: json) else { continue }
            array.append(stations)
        }
        return array
    }
    
}
