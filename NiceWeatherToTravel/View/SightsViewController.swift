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
    
    var context: NSManagedObjectContext! = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext
    
    private var sights:[Sight] = []
    var sightsToShow:[Sight] = []
    
    var sityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromFile()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        let context = getContext()
       
        
        let fetchRequest: NSFetchRequest<Sight> = Sight.fetchRequest()
        
        do{
            sights = try context.fetch(fetchRequest)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    private func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.coreDataStack.persistentContainer.viewContext
    }
    
    private func insertData(sityName: String){
        for s in sights{
            if(s.city == sityName){
                sightsToShow.append(s)
            }
        }
    }
    
    private func getDataFromFile(){
        let fetchRequest: NSFetchRequest<Sight> = Sight.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name != nil")
        
        var records = 0
        
        do{
            records = try context.count(for: fetchRequest)
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        //guard records == 0 else { return }
        
        guard let pathToFile = Bundle.main.path(forResource: "Sights", ofType: "plist"),
            let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        
        for dictionary in dataArray{
            let entity  = NSEntityDescription.entity(forEntityName: "Sight", in: context)
            let sight = NSManagedObject(entity: entity!, insertInto: context) as! Sight
            
            
            let sightDictionary = dictionary as! [String : AnyObject]
            sight.city = sightDictionary["city"] as? String
            sight.name = sightDictionary["name"] as? String
            sight.short_description = sightDictionary["short_description"] as? String
            sight.long_description = sightDictionary["long_description"] as? String
            let imageName = sightDictionary["image"] as? String
            guard let image = UIImage(named: imageName!) else { return }
            let imageData = image.pngData()
            sight.image = imageData
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSightsDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let detailVC = segue.destination as! SightDescriptionViewController
                detailVC.sight = sights[indexPath.row]
            }
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sightsToShow.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sightCell", for: indexPath)
        
        let  sightToShow = sightsToShow[indexPath.row]
        if let imageData = sightToShow.image{
            cell.imageView?.image = UIImage(data: imageData)
        }
        cell.textLabel?.text = sightToShow.name
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = sightToShow.short_description
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
