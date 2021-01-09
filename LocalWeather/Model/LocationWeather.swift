//
//  LocationWeather.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import Foundation

struct LocationWeather {
    let locationName: String
    
    let todayWeather: WeatherModel
    let tomorrowWeather: WeatherModel
}

struct WeatherModel {
    let weatherState: String
    let weatherImage: String
    let temperature: String
    let humidity: String
}
