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
    }    
}
