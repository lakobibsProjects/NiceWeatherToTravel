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

struct CityList{
    
    func GetCities() -> [String]{
        var result: [String] = []
        guard let path = Bundle.main.path(forResource: "city_list", ofType: "json") else { return []}
        let ralativePath: URL = URL(fileURLWithPath: path)
        
        AF.request(
            ralativePath,
            method: .get,
            headers: nil).responseJSON {
                response in
                print ("request engaged")
                if let cities = Mapper<CitiesToParse>().map(JSONObject:response.value){
                    print("if engaged")
                    for city in cities.cities!{
                        result.append(city.name!)
                    }
                }

        }

       return result
    }
        
}

class ParsedCity: Mappable{
    var id: Int?
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

class CitiesToParse: Mappable {
    var cities: [ParsedCity]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cities <- map["cities"]

    }
}
