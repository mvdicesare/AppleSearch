//
//  SearchResultsTableViewController.swift
//  AppleSearch
//
//  Created by Michael Di Cesare on 10/3/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var musicSearchResults: [MusicSearchResult] = []
    var appSearchResults: [AppSearchResults] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = 150
    }

    @IBAction func segmentedControlActionChanged(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {return}
        
        if segmentedControl.selectedSegmentIndex == 0 {
            SearchResultsController.getMusicItems(searchText: searchText) {
                (results) in
                self.musicSearchResults = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                }
            }
        } else if segmentedControl.selectedSegmentIndex == 1 {
            SearchResultsController.getAppItems(searchText: searchText) {
                (results) in
                self.appSearchResults = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                }
            }
        }
    }
    
   
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
            if segmentedControl.selectedSegmentIndex == 0 {
                count = musicSearchResults.count
            } else if segmentedControl.selectedSegmentIndex == 1 {
                count = appSearchResults.count
        }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsCell", for: indexPath)
        as! ResultTableViewCell
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let searchResultItem = musicSearchResults[indexPath.row]
            cell.musicItem = searchResultItem
        } else if segmentedControl.selectedSegmentIndex == 1 {
            let searchResultItem = appSearchResults[indexPath.row]
            cell.appItem = searchResultItem
        }


        return cell
    }
    

 

}// end of class
