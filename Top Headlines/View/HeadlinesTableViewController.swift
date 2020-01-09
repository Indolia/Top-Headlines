//
//  HeadlinesTableViewController.swift
//  Top Headlines
//
//  Created by Rishi pal on 08/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import UIKit

class HeadlinesTableViewController: UITableViewController {
   let headlineViewModel = HeadlinesViewModel()
   let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    
    func uiSetup() {
        title = "Top Headlines"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.registerNib(String(describing: HeadlineTableViewCell.self))
        self.navigationItem.setHidesBackButton(true, animated:true);
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = tableView.center
        tableView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        headlineViewModel.delegate = self
        headlineViewModel.fetchLocalHeadline()
        headlineViewModel.getHeadlines()
        addLogoutButton()
    }
    
    func addLogoutButton() {
        let logoutItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logout"), style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem  = logoutItem
    }
    
    @objc private func logout() {
        LogoutManager.logout()
        DispatchQueue.main.async {
            Indexer().setWelcomeAsRoot()
        }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return headlineViewModel.dataItems.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeadlineTableViewCell.self), for: indexPath) as! HeadlineTableViewCell
        cell.configure(for: headlineViewModel.dataItems[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let headlineModel = headlineViewModel.dataItems[indexPath.row]
        let headlineDetailsViewModel = HeadlineDetailsViewModel(headlineModel: headlineModel)
        let headlineDetailsTableViewController = HeadlineDetailsTableViewController.get(with: headlineDetailsViewModel)
        navigationController?.pushViewController(headlineDetailsTableViewController, animated: true)
    }
}

extension HeadlinesTableViewController : HeadlinesViewModelDelegate {
    func reloadTable() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}
