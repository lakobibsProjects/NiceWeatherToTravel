//
//  SearchViewModel.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation

class SearchViewModel{
    var searchedString: Box<String?> = Box("")
    let cityList: CityList
    let sities: [ParsedCity]
    var sityNames: [String] = []
    private func fillSityNames(){
        var result: [String] = []
        for sity in sities {
            result.append(sity.name!)
        }
    }
        
    init(){
        self.cityList = CityList()
        self.sities = cityList.GetCities()
        fillSityNames()
        print("citynames was filled")
    }
       
        
}
