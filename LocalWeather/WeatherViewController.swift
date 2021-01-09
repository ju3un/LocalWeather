//
//  ViewController.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import UIKit
import Kingfisher

class WeatherViewController: UIViewController {
    @IBOutlet weak var weatherTableView: UITableView!
    
    var weatherManager = WeatherManager()
    var locationWeather: [LocationWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        weatherManager.fetchData()
        
        weatherTableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
    }
    
    deinit {
        //locations.removeAll()
    }
}

//MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        cell.localLabel.text = locationWeather[indexPath.row].locationName
        
        cell.todayWeatherLabel.text = locationWeather[indexPath.row].todayWeather.weatherState
        print(locationWeather[indexPath.row].todayWeather.weatherImage)
        cell.todayWeatherImageView.kf.setImage(with: URL(string: locationWeather[indexPath.row].todayWeather.weatherImage))
        cell.todayTemperatureLabel.text = locationWeather[indexPath.row].todayWeather.temperature
        cell.todayHumidityLabel.text = locationWeather[indexPath.row].todayWeather.humidity
        
        cell.tomorrowWeatherLabel.text = locationWeather[indexPath.row].tomorrowWeather.weatherState
        cell.tomorrowWeatherImageView.kf.setImage(with: URL(string: locationWeather[indexPath.row].tomorrowWeather.weatherImage))
        cell.tomorrowTemperatureLabel.text = locationWeather[indexPath.row].tomorrowWeather.temperature
        cell.tomorrowHumidityLabel.text = locationWeather[indexPath.row].tomorrowWeather.humidity
        
        return cell
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeatherLocation(locationWeather: [LocationWeather]) {
        self.locationWeather = locationWeather
        weatherTableView.reloadData()
    }
}
