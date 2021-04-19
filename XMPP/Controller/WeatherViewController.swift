//
//  WeatherViewController.swift
//  XMPP
//
//  Created by Karthik on 19/04/21.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var city   = [String]()
    var   weather : [Weather]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Weather"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource=self
        tableView.delegate=self
        
        API.shared.loadWeather {
            data in
            self.city.append(contentsOf: data.map{$0.name})
            self.weather=data
            DispatchQueue.main.async {
              self.tableView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    

}

extension  WeatherViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell")
        guard  let weather = weather else {
            return cell!
        }
        cell?.textLabel?.text  = "\(indexPath.row+1) . " + city[indexPath.row] + " - "+String(weather[indexPath.row].main.temp)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CityWeatherViewController") as!  CityWeatherViewController
        guard let  weather =  self.weather?[indexPath.row]   else {
            return
        }
        vc.weather = weather
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
