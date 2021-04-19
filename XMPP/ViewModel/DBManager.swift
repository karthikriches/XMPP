//
//  DBManager.swift
//  XMPP
//
//  Created by Karthik on 19/04/21.
//

import UIKit
import CoreData

struct model {
    var city : String
    var temperature : Double
    var minTemp : Double
    var maxTemp : Double
    var humidity : Int
    var pressure :  Int
    
    
}

class DBManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static  let shared  = DBManager()
    var dbData =  [model]()
    
    private init()  {
        
    }
    
    func   createData(weather  :Weather)  {
        let entity = WeatherEntity(context:context)
        entity.city =  weather.name
        entity.temperature = Int32(weather.main.temp)
        entity.minTemp = Int32(weather.main.tempMin)
        entity.maxTemp = Int32(weather.main.tempMax)
        entity.humidity = Int32(weather.main.humidity)
        entity.pressure = Int32(weather.main.pressure)
        
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func readData()->[model] {
        let request :  NSFetchRequest = WeatherEntity.fetchRequest()
        
        dbData = []
        do {
            var data =  try context.fetch(request)
            for record in data {
                let city = record.value(forKey: "city") as! String
                let temp = record.value(forKey: "temperature") as! Double
                let minTemp = record.value(forKey: "minTemp") as!  Double
                let maxTemp = record.value(forKey: "maxTemp")  as! Double
                let humidity = record.value(forKey: "humidity") as! Int
                let pressure = record.value(forKey: "pressure") as! Int
                dbData.append(model(city: city, temperature: Double(temp), minTemp: minTemp, maxTemp: maxTemp, humidity: humidity, pressure: pressure))
            }
        }
        catch {
            
        }
        return dbData
    }
    
}
