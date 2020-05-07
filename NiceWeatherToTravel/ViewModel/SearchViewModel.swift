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
    let cityProvider: CityProvider = CityProvider()
    let sities: [ParsedCity] = []
        
    init(){
        //self.sities = cityProvider.GetSearchedCities(sityName: searchedString)
    }

}
