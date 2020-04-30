//
//  SityList.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ParsedCity: Decodable{
    var id: Int
    var name: String
    var country: String
    var lat: Double
    var lon: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case lat = "latitude"
        case lon = "longitude"
    }
}

class RequestedCities: Decodable {
    let requestedCities: [ParsedCity]?
    
    enum CodingKeys: String, CodingKey {
        case requestedCities = "data"
    }
    
}
 
