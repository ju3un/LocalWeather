//
//  WeatherManager.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import Alamofire

protocol WeatherManagerDelegate {
    func didUpdateWeatherLocation(locationWeather: [LocationWeather])
}

struct WeatherManager {
    let locationUrl = "https://www.metaweather.com/api/location/search/?query=se"
    let weatherUrl = "https://www.metaweather.com/api/location/"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchData() {
        AF.request(self.locationUrl, method: .get).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let locations = try JSONDecoder().decode([Location].self, from: data)
                    requestWeather(locations: locations)
                } catch {
                    print("Request failed with error: ", error.localizedDescription)
                }
            case .failure(let error):
                print("Request failed with error: ", error.errorDescription ?? "")
            }
        }
    }
    
    func requestWeather(locations: [Location]) {
        var locationWeather: [LocationWeather] = []
        for location in locations {
            AF.request(weatherUrl + String(location.woeid), method: .get).responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                        
                        /// FIX_ME: 예외처리 필요
                        let todayWeather = weatherData.consolidatedWeather[0].toWeatherModel()
                        let tomorrowWeather = weatherData.consolidatedWeather[1].toWeatherModel()
                        locationWeather.append(LocationWeather(locationName: location.name, todayWeather: todayWeather, tomorrowWeather: tomorrowWeather))
                        
                        if locationWeather.count == locations.count {
                            delegate?.didUpdateWeatherLocation(locationWeather: locationWeather)
                        }
                    } catch {
                        print("Request failed with error: ", error.localizedDescription)
                    }
                case .failure(let error):
                    print("Request failed with error: ", error.errorDescription ?? "")
                }
            }
        }
    }
}
