//
//  HeadlineDetailesTableViewController.swift
//  Top Headlines
//
//  Created by Rishi pal on 09/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import UIKit

class HeadlineDetailsTableViewController: UITableViewController {
    var headlineDetailsViewModel: HeadlineDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib("HeadlineDetailsTableViewCell")
        navigationItem.largeTitleDisplayMode = .never
    }
    
    class func get(with viewModel : HeadlineDetailsViewModel)-> HeadlineDetailsTableViewController {
        let headLineDetailsViewController = HeadlineDetailsTableViewController.get(with: AppConstants.ViewControllerStotyboardId.headlineDetailsTableViewController, storyboard: AppConstants.Storyboard.main)
        
        guard let someVC = headLineDetailsViewController as? HeadlineDetailsTableViewController else {
            fatalError("HeadLineDetailsViewController not find")
        }
        
        someVC.headlineDetailsViewModel = viewModel
        return someVC
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineDetailsTableViewCell", for: indexPath) as!HeadlineDetailsTableViewCell

        // Configure the cell...
        cell.configure(model: headlineDetailsViewModel.headlineModel)
        return cell
    }
    

}
