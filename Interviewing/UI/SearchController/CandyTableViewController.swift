//
//  SongTableViewController.swift
//  Interviewing
//
//  Created by Алексей on 07.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class CandyTableViewController: UITableViewController {
    
    let candys = [
        Candy(category:"Chocolate", name:"Chocolate Bar"),
        Candy(category:"Chocolate", name:"Chocolate Chip"),
        Candy(category:"Chocolate", name:"Dark Chocolate"),
        Candy(category:"Hard", name:"Lollipop"),
        Candy(category:"Hard", name:"Candy Cane"),
        Candy(category:"Hard", name:"Jaw Breaker"),
        Candy(category:"Other", name:"Caramel"),
        Candy(category:"Other", name:"Sour Chew"),
        Candy(category:"Other", name:"Gummi Bear"),
        Candy(category:"Other", name:"Candy Floss"),
        Candy(category:"Chocolate", name:"Chocolate Coin"),
        Candy(category:"Chocolate", name:"Chocolate Egg"),
        Candy(category:"Other", name:"Jelly Beans"),
        Candy(category:"Other", name:"Liquorice"),
        Candy(category:"Hard", name:"Toffee Apple")
    ]
    
    var filteredSongs = [Candy]()
    
    var searchController = UISearchController.init(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
    }
    
    func searchBarIsEmpty() -> Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All"){
        filteredSongs = candys.filter { (song) -> Bool in
            return song.name.lowercased().contains(searchText.lowercased()) &&
                (song.category.contains(scope) || scope == "All")
        }
        tableView.reloadData()
    }
    
    func createSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Finded"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering(){
            return filteredSongs.count
        }
        return candys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let song: Candy
        
        if isFiltering(){
            song = filteredSongs[indexPath.row]
        } else {
            song = candys[indexPath.row]
        }
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.category
        return cell
    }
}

extension CandyTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults")
        filterContentForSearchText(searchController.searchBar.text!, scope: searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex])
    }
}

extension CandyTableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
