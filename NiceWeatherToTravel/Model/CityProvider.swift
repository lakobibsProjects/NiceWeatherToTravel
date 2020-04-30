//
//  CityProvider.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 3/3/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CityProvider{
    let BASEURL = "http://geodb-free-service.wirefreethought.com/v1/geo/cities?limit=5&offset=0&namePrefix="
    var cities: [ParsedCity]?
    
    func GetSearchedCities(sityName: String) -> [ParsedCity]?{
        
        let urlString = "\(BASEURL)\(sityName)"
        if let url = URL(string: urlString){
            do{
                let data = try Data(contentsOf: url)
                let parsedResult: RequestedCities = try! JSONDecoder().decode(RequestedCities.self, from: data)
                self.cities = parsedResult.requestedCities
            } catch is URLError {
                print("Incorrect url")
            } catch is CFNetworkErrors{
                print("Some problems with network connection")
            } catch {
                print("Unexpected error when parsing cities")
            }
        }
        
        return cities ?? nil
    }
}
