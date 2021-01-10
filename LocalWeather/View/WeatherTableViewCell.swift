//
//  WeatherTableViewCell.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var weatherStackView: UIStackView!
    
    @IBOutlet weak var todayWeatherImageView: UIImageView!
    @IBOutlet weak var todayWeatherLabel: UILabel!
    @IBOutlet weak var todayTemperatureLabel: UILabel!
    @IBOutlet weak var todayHumidityLabel: UILabel!
    
    @IBOutlet weak var tomorrowWeatherImageView: UIImageView!
    @IBOutlet weak var tomorrowWeatherLabel: UILabel!
    @IBOutlet weak var tomorrowTemperatureLabel: UILabel!
    @IBOutlet weak var tomorrowHumidityLabel: UILabel!
    
    @IBOutlet weak var localLabelBorder: UIStackView!
    @IBOutlet weak var todayLabelBorder: UIStackView!
    @IBOutlet weak var tomorrowLabelBorder: UIStackView!
    @IBOutlet weak var todayWeatherBorder: UIStackView!
    @IBOutlet weak var tomorrowWeatherBorder: UIStackView!
    
    var borders: [UIView] = []
    var bottomBorders: [UIView] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// FIX_ME: 매우 비효율적인 방법이라고 생각된다..
        for border in localLabelBorder.addBorder([.left, .top], color: UIColor.systemGray5, width: 1.0) {
            borders.append(border)
        }
        for border in todayLabelBorder.addBorder([.left, .top], color: UIColor.systemGray5, width: 1.0) {
            borders.append(border)
        }
        for border in tomorrowLabelBorder.addBorder([.left, .right, .top], color: UIColor.systemGray5, width: 1.0) {
            borders.append(border)
        }
        for border in todayWeatherBorder.addBorder([.left, .top], color: UIColor.systemGray5, width: 1.0) {
            borders.append(border)
        }
        for border in tomorrowWeatherBorder.addBorder([.left, .right, .top], color: UIColor.systemGray5, width: 1.0) {
            borders.append(border)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    deinit {
        for border in borders {
            border.removeFromSuperview()
        }
        for border in bottomBorders {
            border.removeFromSuperview()
        }
        borders.removeAll()
        bottomBorders.removeAll()
    }
    
    func addBottomBorder() {
        for border in localLabelBorder.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0) {
            bottomBorders.append(border)
        }
        for border in todayWeatherBorder.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0) {
            bottomBorders.append(border)
        }
        for border in tomorrowWeatherBorder.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0) {
            bottomBorders.append(border)
        }
    }
    
    func removeBottomBorder() {
        for border in bottomBorders {
            border.removeFromSuperview()
        }
        bottomBorders.removeAll()
    }
}
