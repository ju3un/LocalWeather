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
    var locationWeatherList: [LocationWeather] = []
    
    var spinner: UIActivityIndicatorView? = UIActivityIndicatorView()
    
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
        
        spinner?.startAnimating()
        weatherManager.fetchData { (locationWeather, error) in
            if let error = error {
                let alert = UIAlertController(title: "응답 실패", message: "\(error.localizedDescription)\n재시도하시기 바랍니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                if let locationWeather = locationWeather {
                    self.locationWeatherList = locationWeather
                    self.weatherTableView.reloadData()
                }
                self.spinner?.stopAnimating()
            }
        }
    }
    
    deinit {
        spinner?.removeFromSuperview()
        spinner = nil
        locationWeatherList.removeAll()
    }
    
    func initSpinner() {
        spinner?.hidesWhenStopped = true
        spinner?.center = CGPoint(x:weatherTableView.bounds.size.width / 2, y:weatherTableView.bounds.size.height / 2)
        weatherTableView.addSubview(spinner!)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        locationWeatherList.removeAll()
        weatherTableView.reloadData()
        
        weatherManager.fetchData { (locationWeather, error) in
            if let error = error {
                let alert = UIAlertController(title: "응답 실패", message: "\(error.localizedDescription)\n재시도하시기 바랍니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                if let locationWeather = locationWeather {
                    self.locationWeatherList = locationWeather
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
        return locationWeatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        if indexPath.row == 0 {
            cell.headerStackView.isHidden = false
            cell.weatherStackView.isHidden = true
            
            cell.backgroundColor = UIColor.systemGray6
            cell.localLabel.text = locationWeatherList[indexPath.row].locationName
        } else {
            cell.headerStackView.isHidden = true
            cell.weatherStackView.isHidden = false
            
            cell.backgroundColor = .clear
            cell.localLabel.text = locationWeatherList[indexPath.row].locationName
            
            if let todayWeather = locationWeatherList[indexPath.row].todayWeather {
                cell.todayWeatherLabel.text =  todayWeather.weatherState
                cell.todayWeatherImageView.kf.setImage(with: URL(string: todayWeather.weatherImage))
                cell.todayTemperatureLabel.text = todayWeather.temperature
                cell.todayHumidityLabel.text = todayWeather.humidity
            }
            
            if let tomorrowWeather = locationWeatherList[indexPath.row].tomorrowWeather {
                cell.tomorrowWeatherLabel.text = tomorrowWeather.weatherState
                cell.tomorrowWeatherImageView.kf.setImage(with: URL(string: tomorrowWeather.weatherImage))
                cell.tomorrowTemperatureLabel.text = tomorrowWeather.temperature
                cell.tomorrowHumidityLabel.text = tomorrowWeather.humidity
            }
            
            if indexPath.row == locationWeatherList.count - 1 {
                cell.addBottomBorder()
            }
        }
        return cell
    }
}
