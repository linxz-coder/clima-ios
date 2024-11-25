//
//  WeatherData.swift
//  Clima
//
//  Created by 林晓中 on 2024/11/25.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable{
    let description: String
    let id: Int
}
