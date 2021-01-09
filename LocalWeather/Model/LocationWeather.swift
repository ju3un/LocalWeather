//
//  LocationWeather.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import Foundation

class LocationWeather {
    let locationName: String
    
    var todayWeather: WeatherModel?
    var tomorrowWeather: WeatherModel?
    
    init(locationName: String) {
        self.locationName = locationName
    }
}

struct WeatherModel {
    let weatherState: String
    let weatherImage: String
    let temperature: String
    let humidity: String
}
