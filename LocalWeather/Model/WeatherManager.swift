//
//  WeatherManager.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import Alamofire

struct WeatherManager {
    let locationUrl = "https://www.metaweather.com/api/location/search/?query=se"
    let weatherUrl = "https://www.metaweather.com/api/location/"
    
    /// FIX_ME: alamofire 비동기라서 데이터가 뒤죽박죽
    func fetchData(completion: @escaping ([LocationWeather]?, Error?) -> Void) {
        requestLocation { (locations, error) in
            if let error = error {
                print("Request failed with error: ", error.localizedDescription)
                completion(nil, error)
            } else {
                if let locations = locations {
                    requestWeather(locations: locations) { (locationWeather, error) in
                        if let error = error {
                            print("Request failed with error: ", error.localizedDescription)
                            completion(nil, error)
                        } else {
                            completion(locationWeather, nil)
                        }
                    }
                }
            }
        }
    }
    
    func requestLocation(completion: @escaping ([Location]?, Error?) -> Void) {
        AF.request(self.locationUrl, method: .get).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let locations = try JSONDecoder().decode([Location].self, from: data)
                    completion(locations, nil)
                } catch {
                    print("Request failed with error: ", error.localizedDescription)
                    completion(nil, error)
                }
            case .failure(let error):
                print("Request failed with error: ", error.errorDescription ?? "")
                completion(nil, error)
            }
        }
    }
    
    func requestWeather(locations: [Location], completion: @escaping ([LocationWeather]?, Error?) -> Void) {
        var locationWeatherList: [LocationWeather] = [LocationWeather(locationName: "Local", todayWeather: WeatherModel(weatherState: "", weatherImage: "", temperature: "", humidity: ""), tomorrowWeather: WeatherModel(weatherState: "", weatherImage: "", temperature: "", humidity: ""))]
        for location in locations {
            AF.request(weatherUrl + String(location.woeid), method: .get).responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                        
                        /// FIX_ME: 예외처리 필요
                        let todayWeather = weatherData.consolidatedWeather[0].toWeatherModel()
                        let tomorrowWeather = weatherData.consolidatedWeather[1].toWeatherModel()
                        locationWeatherList.append(LocationWeather(locationName: location.name, todayWeather: todayWeather, tomorrowWeather: tomorrowWeather))
                        
                        if locationWeatherList.count == locations.count {
                            completion(locationWeatherList, nil)
                        }
                    } catch {
                        print("Request failed with error: ", error.localizedDescription)
                        completion(nil, error)
                    }
                case .failure(let error):
                    print("Request failed with error: ", error.errorDescription ?? "")
                    completion(nil, error)
                }
            }
        }
    }
}
