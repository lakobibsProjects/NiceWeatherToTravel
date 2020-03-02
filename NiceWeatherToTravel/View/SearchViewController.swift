//
//  SearchViewController.swift
//  NiceWhetherToTravel
//
//  Created by user166683 on 2/25/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit
//TODO: cast to MVVM paradigme due boxing
class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var SearchresultTableView: UITableView!
       
    
    var viewModel: SearchViewModel? = SearchViewModel()
    var cities = [String]()
    var searchCities = [String]()
    var searching = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // guard let viewModel  = SearchViewModel() else {return}
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        viewModel?.searchedString.bind{ [unowned self] in
            guard let searchedString = $0 else {return}
            
        }*/
        cities = viewModel?.sityNames ?? []
        
        searchBar.delegate = self
        searchBar.searchTextField.textColor = UIColor.gray
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCities = cities.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        SearchresultTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = "Search"
        searchBar.searchTextField.textColor = UIColor.gray
        searchBar.showsCancelButton = false
        SearchresultTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.searchTextField.textColor = UIColor.white
        searchBar.showsCancelButton = true
    }
    
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchCities.count
        }else{
            return cities.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")
        cell?.textLabel?.textColor = UIColor.white
        if searching{
            cell?.textLabel?.text = searchCities[indexPath.row]
        }else{
            cell?.textLabel?.text = cities[indexPath.row]
        }
        
        return cell!
    }
    
    
}
