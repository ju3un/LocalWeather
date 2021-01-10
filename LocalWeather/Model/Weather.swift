//
//  Weather.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import Foundation

struct WeatherData: Codable {
    let weathers: [Weather]
    
    enum CodingKeys: String, CodingKey  {
        case weathers = "consolidated_weather"
    }
}

struct Weather: Codable {
    let state: String
    let abbreviation: String
    let temperature: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case state = "weather_state_name"
        case abbreviation = "weather_state_abbr"
        case temperature = "the_temp"
        case humidity = "humidity"
    }
    
    func toWeatherModel() -> WeatherModel {
        let copy = WeatherModel(weatherState: state, weatherImage: "https://www.metaweather.com/static/img/weather/png/\(abbreviation).png", temperature: "\(Int(temperature))", humidity: "\(humidity)")
        return copy
    }
}
