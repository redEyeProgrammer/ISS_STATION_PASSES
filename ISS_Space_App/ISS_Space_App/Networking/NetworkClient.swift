//
//  NetworkClient.swift
//  ISS_Space_App
//
//  Created by redEyeProgrammer on 12/13/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import Foundation


public final class NetworkClient {
    
    // MARK: - Instance Properties
    internal let baseURL: URL
    internal let session = URLSession.shared
    internal let sessionConfig = URLSessionConfiguration.ephemeral
    
    // MARK: - Class Constructors
    public static let shared: NetworkClient = {
        let file = Bundle.main.path(forResource: "ServerEnvironments", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)!
        let urlString = dictionary["service_url"] as! String
        let url = URL(string: urlString)!
        return NetworkClient(baseURL: url)
    }()
    
    // MARK: - Object Lifecycle
    private init(baseURL: URL) {
        //Retrieve BaseURL from PList
        self.baseURL = baseURL
        
    }
    
    
    //Method to call URL API and parse data into Stations Model
    public func getPasses(_ latitue: String, longitude : String, success _success: @escaping ([Stations]) -> Void,
                          failure _failure: @escaping (NetworkError) -> Void) {
        
        let success : ([Stations]) -> Void = { stations in
            DispatchQueue.main.async { _success(stations) }
        }
        
        let failure : (NetworkError) -> Void = { error in
            DispatchQueue.main.async { _failure (error) }
        }
        
        let url = URL(string: String(describing: self.baseURL) + "/iss-pass.json?lat=\(latitue)&lon=\(longitude)")
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode.isSuccessHTTPCode,
                let data = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: data),
                let jsonPayload = jsonObject as? [String : Any],
                let _ = jsonPayload["request"] as? [String : Any],
                let responseArray = jsonPayload["response"] as? [[String: Any]] else {
                    if let error = error {
                        failure(NetworkError(error: error))
                    } else {
                        failure(NetworkError(response: response))
                    }
                    return
            }
        
            let stations = Stations.array(responseArray: responseArray)
            success(stations)
        }
        
        task.resume()
        
    }
}



