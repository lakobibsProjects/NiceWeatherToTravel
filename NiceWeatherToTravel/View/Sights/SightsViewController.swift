//
//  SightsViewController.swift
//  NiceWhetherToTravel
//
//  Created by user166683 on 2/26/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit
import CoreData

class SightsViewController: UITableViewController {
    
    private var vm: SightsViewModel?
    var sityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sn = sityName{
            vm = SightsViewModel(sityName: sn)
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        if let sn = sityName{
            vm = SightsViewModel(sityName: sn)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSightsDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let detailVC = segue.destination as! SightDescriptionViewController
                detailVC.sight = vm?.sightsToShow[indexPath.row]
            }
        }
    }
}

    // MARK: - TableView setup
extension SightsViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.sightsToShow.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: SightsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "sightCell", for: indexPath) as? SightsTableViewCell{
            if let image = vm?.sightsToShow[indexPath.row].image{
                cell.sightImageView.image = UIImage(data: image)
            }
            
            cell.sightNameLabel.text = vm?.sightsToShow[indexPath.row].name
            cell.sightNameLabel.numberOfLines = 1
            
            cell.sightDescriptionLabel.text = vm?.sightsToShow[indexPath.row].short_description
            cell.sightDescriptionLabel.numberOfLines = 3
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(vm?.sightsToShow.count ?? 0)
    }
}
