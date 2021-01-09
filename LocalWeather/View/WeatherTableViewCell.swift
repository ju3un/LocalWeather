//
//  WeatherTableViewCell.swift
//  LocalWeather
//
//  Created by ju3un on 2021/01/06.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var todayWeatherImageView: UIImageView!
    @IBOutlet weak var todayWeatherLabel: UILabel!
    @IBOutlet weak var todayTemperatureLabel: UILabel!
    @IBOutlet weak var todayHumidityLabel: UILabel!
    
    @IBOutlet weak var tomorrowWeatherImageView: UIImageView!
    @IBOutlet weak var tomorrowWeatherLabel: UILabel!
    @IBOutlet weak var tomorrowTemperatureLabel: UILabel!
    @IBOutlet weak var tomorrowHumidityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
