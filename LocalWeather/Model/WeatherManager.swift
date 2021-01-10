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
    
    func fetchData(completion: @escaping ([LocationWeather]?, Error?) -> Void) {
        requestLocation { (locations, error) in
            if let error = error {
                print("Request failed with error: ", error.localizedDescription)
                completion(nil, error)
            } else {
                var locationWeatherList: [LocationWeather] = [LocationWeather(locationName: "Local")]
                
                if let locations = locations {
                    var requestCount = 0
                    for location in locations {
                        // alamofire 비동기라 우선 순서대로 담는 방법 선택
                        locationWeatherList.append(LocationWeather(locationName: location.name))
                        requestWeather(location: location) { (weatherData, error) in
                            requestCount += 1
                            if let error = error {
                                print("Request failed with error: ", error.localizedDescription)
                                completion(nil, error)
                            } else {
                                if let weatherData = weatherData {
                                    if weatherData.weathers.count > 1 {
                                        let todayWeather = weatherData.weathers[0].toWeatherModel()
                                        let tomorrowWeather = weatherData.weathers[1].toWeatherModel()
                                        
                                        let locationWeather = locationWeatherList.filter { $0.locationName == location.name }
                                        locationWeather[0].todayWeather = todayWeather
                                        locationWeather[0].tomorrowWeather = tomorrowWeather
                                    }
                                }
                            }
                            
                            if requestCount == locations.count {
                                completion(locationWeatherList, nil)
                            }
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
    
    func requestWeather(location: Location, completion: @escaping (WeatherData?, Error?) -> Void) {
        AF.request(weatherUrl + String(location.woeid), method: .get).responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    
                    completion(weatherData, nil)
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
