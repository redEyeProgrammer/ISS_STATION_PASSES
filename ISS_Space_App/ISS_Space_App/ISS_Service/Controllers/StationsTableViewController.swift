//
//  StationsTableViewController.swift
//  ISS_Space_App
//
//  Created by redEyeProgrammer on 12/13/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import UIKit

class StationsTableViewController: UITableViewController {
    
    var longitude: String?
    var latitude: String?
    var requestDict: [String : Any]?
    // MARK: - Injections
    internal var networkClient = NetworkClient.shared
    
    
    // MARK: - Instance Properties
    internal var stationsViewModels: [StationViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPasses()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    internal func loadPasses() {
        
        tableView.refreshControl?.beginRefreshing()
        networkClient.getPasses(latitude ?? "", longitude: longitude ?? "", success: { [weak self] stations in
            guard let weakSelf = self else { return }
            weakSelf.stationsViewModels = stations.map{StationViewModel(station : $0)}
            weakSelf.tableView.refreshControl?.endRefreshing()
            weakSelf.tableView.reloadData()
            }, requestDict: { [weak self] requestPayload in
                guard let weakSelf = self else { return }
                weakSelf.requestDict = requestPayload
        }) { [weak self] error in
            guard let weakSelf = self else { return }
            weakSelf.showToastWith(title: "Error", message: error.localizedDescription, withAction: nil)
            weakSelf.tableView.refreshControl?.endRefreshing()
        }
        
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stationsViewModels.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let stationViewModel = stationsViewModels[indexPath.row]
        
        // Configure the cell...
        stationViewModel.configure(cell as StationViewModelView)
        
        return cell
    }
    
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tableViewController = segue.destination as? DetailsViewController else { return }
        if segue.identifier == "detailsSegue" {
            tableViewController.requestDict = requestDict
        }
    }
    
}
