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
    @IBOutlet weak var navigator: UINavigationItem!
    
    //remove this after connect boxing
    private let provider = CityProvider()
    var viewModel: SearchViewModel? = SearchViewModel()
    var cities = [ParsedCity]()
    var searchCities = [String]()
    var searching = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       // guard let viewModel  = SearchViewModel() else {return}
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        searchBar.delegate = self
        searchBar.searchTextField.textColor = UIColor.gray
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeather"{
            if let indexPath = self.SearchresultTableView.indexPathForSelectedRow{
                let detailVC = segue.destination as! WeatherViewController
                detailVC.city = cities[indexPath.row]
            }
            
        }
    }
    

}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let cityPrefix = searchBar.text{
            if let request = provider.GetSearchedCities(sityName: cityPrefix){
                cities = request
            }
        }
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
    override func didChangeValue(forKey key: String) {
        SearchresultTableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.text = cities[indexPath.row].name
        
        return cell!
    }
    
    
}
