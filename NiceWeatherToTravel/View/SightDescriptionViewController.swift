//
//  SightDescriptionViewController.swift
//  NiceWhetherToTravel
//
//  Created by user166683 on 2/26/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import UIKit
import MapKit

class SightDescriptionViewController: UIViewController {

    @IBOutlet weak var sightName: UILabel!
    @IBOutlet weak var sightImage: UIImageView!
    @IBOutlet weak var sightShortDescription: UITextView!
    @IBOutlet weak var sightLondDescription: UITextView!
    @IBOutlet weak var sightLocation: MKMapView!
    
    var sight:Sight?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let sight = sight else{return}
        sightName.text = sight.name
        if let imageData = sight.image{
            sightImage.image = UIImage(data: imageData)
        }
        sightShortDescription.text = sight.short_description
        sightLondDescription.text = sight.long_description
        // Do any additional setup after loading the view.
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
