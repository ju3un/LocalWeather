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
    
    let spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        
        initSpinner()
        
        weatherTableView.refreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
            return refreshControl
        }()
        
        spinner.startAnimating()
        weatherManager.fetchData { (locationWeather, error) in
            if let error = error {
                let alert = UIAlertController(title: "응답 실패", message: "\(error.localizedDescription)\n재시도하시기 바랍니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                if let locationWeather = locationWeather {
                    self.locationWeather = locationWeather
                    self.weatherTableView.reloadData()
                }
                self.spinner.stopAnimating()
            }
        }
    }
    
    deinit {
        spinner.removeFromSuperview()
        locationWeather.removeAll()
    }
    
    func initSpinner() {
        spinner.hidesWhenStopped = true
        spinner.center = CGPoint(x:weatherTableView.bounds.size.width / 2, y:weatherTableView.bounds.size.height / 2)
        weatherTableView.addSubview(spinner)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        weatherManager.fetchData { (locationWeather, error) in
            if let error = error {
                let alert = UIAlertController(title: "응답 실패", message: "\(error.localizedDescription)\n재시도하시기 바랍니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                if let locationWeather = locationWeather {
                    self.locationWeather = locationWeather
                    self.weatherTableView.reloadData()
                }
            }
            sender.endRefreshing()
        }
    }
}

//MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        if indexPath.row == 0 {
            cell.headerStackView.isHidden = false
            cell.weatherStackView.isHidden = true
            
            cell.localLabel.text = locationWeather[indexPath.row].locationName
        } else {
            cell.headerStackView.isHidden = true
            cell.weatherStackView.isHidden = false
            
            cell.localLabel.text = locationWeather[indexPath.row].locationName
            
            cell.todayWeatherLabel.text = locationWeather[indexPath.row].todayWeather.weatherState
            cell.todayWeatherImageView.kf.setImage(with: URL(string: locationWeather[indexPath.row].todayWeather.weatherImage))
            cell.todayTemperatureLabel.text = locationWeather[indexPath.row].todayWeather.temperature
            cell.todayHumidityLabel.text = locationWeather[indexPath.row].todayWeather.humidity
            
            cell.tomorrowWeatherLabel.text = locationWeather[indexPath.row].tomorrowWeather.weatherState
            cell.tomorrowWeatherImageView.kf.setImage(with: URL(string: locationWeather[indexPath.row].tomorrowWeather.weatherImage))
            cell.tomorrowTemperatureLabel.text = locationWeather[indexPath.row].tomorrowWeather.temperature
            cell.tomorrowHumidityLabel.text = locationWeather[indexPath.row].tomorrowWeather.humidity
        }
        
        return cell
    }
}
