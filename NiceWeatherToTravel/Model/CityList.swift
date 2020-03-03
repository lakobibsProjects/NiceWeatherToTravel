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

class ParsedCity: Mappable{
    var id: Int?
    var name: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        country <- map["country"]
        lat <- map ["latitude"]
        lon <- map ["longitude"]

    }
}

class RequestedCities: Mappable {
    var requestedCities: [ParsedCity]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        requestedCities <- map["data"]

    }
}
