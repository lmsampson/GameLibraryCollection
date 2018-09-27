//
//  SearchTableViewController.swift
//  GameLibraryCollections
//
//  Created by Lisa Sampson on 9/24/18.
//  Copyright © 2018 Lisa M Sampson. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        self.tableView.separatorStyle = .none
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        gameController.searchForGame(with: searchTerm) { (error) in
            
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameController.searchedGames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameSearchedCell", for: indexPath) as! SearchTableViewCell
        
        let gameRep = gameController.searchedGames[indexPath.row]
        cell.gameRep = gameRep

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            let destinationVC = segue.destination as! GameDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destinationVC.gameController = gameController
            destinationVC.gameRep = gameController.searchedGames[indexPath.row]
        }
    }

    // MARK: - Properties
    
    var gameController = GameController()

    @IBOutlet weak var searchBar: UISearchBar!
    
}
