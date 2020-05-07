//
//  SightsViewModel.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 5/1/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation

class SightsViewModel {
    private var provider = SightsProvider()    
    var sightsToShow:[Sight] = []
    
    init(sityName: String){
        insertData(sityName: sityName)
    }
    
    private func insertData(sityName: String){
        for s in provider.sights{
            if(s.city == sityName){
                sightsToShow.append(s)
            }
        }
    }
}
