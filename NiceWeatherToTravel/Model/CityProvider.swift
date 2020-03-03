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
    var cities: RequestedCities?

    func GetSearchedCities(sityName: String) -> RequestedCities?{

        let urlString = "\(BASEURL)\(sityName)"

        AF.request(
            urlString,
            method: .get,
            headers: nil).responseJSON {
                response in
            let mappedCities = Mapper<RequestedCities>().map(JSONObject:response.value)
                self.cities = mappedCities
        }

           return cities ?? nil
        }
            


    

}
