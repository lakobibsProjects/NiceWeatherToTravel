//
//  SearchViewController.swift
//  NiceWhetherToTravel
//
//  Created by user166683 on 2/25/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var SearchresultTableView: UITableView!
    
    let viewModel: SearchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.searchTextField.textColor = UIColor.white
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UISearchBarDelegate{
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.GetAppropriatedSearchResults(searchedText: "", numberOfResults: 100).capacity
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")
        cell?.textLabel?.text = viewModel.GetAppropriatedSearchResults(searchedText: "", numberOfResults: 100)[indexPath.row]
        cell?.textLabel?.textColor = UIColor.white
        
        return cell!
    }
    
    
}
