//
//  SearchViewModel.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation

class SearchViewModel{
    //private let provider = WeatherProvider(sityName: <#String#>)
    private let sities = CityList().GetCities()
    
    func GetAppropriatedSearchResults(searchedText: String, numberOfResults: Int) -> [String]{
        var result: [String] = []
        var iterator = 0
        for sity in sities {
            if sity.starts(with: searchedText){
                result.append(sity)
                iterator = +1
            }
            if iterator >= 5{
                return result
            }
        }
        return result
    }
}
