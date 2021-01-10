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
    
    var reusableBorders: [UIView] = []
    var specialBorders: [UIView] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.removeBottomBorder()
    }
    
    deinit {
        for border in reusableBorders {
            border.removeFromSuperview()
        }
        for border in specialBorders {
            border.removeFromSuperview()
        }
        reusableBorders.removeAll()
        specialBorders.removeAll()
    }
    
    func initialize() {
        borderDelegate = self
        localLabelBorder.addBorder([.left, .top], color: UIColor.systemGray5, width: 1.0)
        todayLabelBorder.addBorder([.left, .top], color: UIColor.systemGray5, width: 1.0)
        tomorrowLabelBorder.addBorder([.left, .right, .top], color: UIColor.systemGray5, width: 1.0)
        todayWeatherBorder.addBorder([.left, .top], color: UIColor.systemGray5, width: 1.0)
        tomorrowWeatherBorder.addBorder([.left, .right, .top], color: UIColor.systemGray5, width: 1.0)
    }
    
    func addBottomBorder() {
        localLabelBorder.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0, reusable: false)
        todayWeatherBorder.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0, reusable: false)
        tomorrowWeatherBorder.addBorder([.bottom], color: UIColor.systemGray5, width: 1.0, reusable: false)
    }
    
    func removeBottomBorder() {
        if !specialBorders.isEmpty {
            for border in specialBorders {
                border.removeFromSuperview()
            }
            specialBorders.removeAll()
        }
    }
}

//MARK: - BorderDelegate
extension WeatherTableViewCell: BorderDelegate {
    func updatedBorder(with border: UIView, reusable: Bool) {
        if reusable {
            reusableBorders.append(border)
        } else {
            specialBorders.append(border)
        }
    }
}
