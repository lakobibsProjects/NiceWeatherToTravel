//
//  SearchViewModel.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation

class SearchViewModel{
    private let sities = CityList().GetCities()
    private var sityNames: [String]
    
    func GetAppropriatedSearchResults(searchedText: String = "", numberOfResults: Int = 100) -> [String]{
        var result: [String] = []
        for sity in sityNames {
            if sity.starts(with: searchedText){
                result.append(sity)
            }
            if numberOfResults <= result.count{
                return result
            }
        }
        return result
    }
        
        init(){
            sityNames = []
            for sity in sities{
                sityNames.append(sity.name!)
            }
        }
        
}
