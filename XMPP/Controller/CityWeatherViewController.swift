//
//  CityWeatherViewController.swift
//  XMPP
//
//  Created by Karthik on 19/04/21.
//

import UIKit

class CityWeatherViewController: UIViewController {

    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressueLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var minTemp: UILabel!
    var weather :  Weather?
    
    @IBOutlet weak var maxTemp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard  let weather =  weather else {
            return
        }
        title = weather.name
        cityLabel.text = "city : " + weather.name
        tempLabel.text = "temperature : "+String(weather.main.temp)
        pressueLabel.text = "pressure : "+String(weather.main.pressure)
        humidityLabel.text = "humidity : "+String(weather.main.humidity)
        minTemp.text = "min temperature :  " + String(weather.main.tempMin)
        maxTemp.text = "max temperature :  " + String(weather.main.tempMax)

    }
    

}
