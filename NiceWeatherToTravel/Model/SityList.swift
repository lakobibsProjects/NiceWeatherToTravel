//
//  SityList.swift
//  NiceWeatherToTravel
//
//  Created by user166683 on 2/27/20.
//  Copyright © 2020 user166683. All rights reserved.
//

import Foundation

struct SityList{
    func GetSitiesArray() -> [String]{
        var result: [String] = []
        if let path = Bundle.main.path(forResource: "city_list", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
                    let toResult = jsonResult["name"] as? [String] {
                    result = toResult
                  }
              } catch {
                print(error)
              }
        }
        return result
    }
}
