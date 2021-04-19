//
//  API.swift
//  XMPP
//
//  Created by Karthik on 19/04/21.
//

import Foundation


class API {
    
    static let shared = API()
    
    private init() {
        
    }
    
    func loadWeather(completion : @escaping ([Weather])->()) {
        let key =  "e35a5afb2a05e93dcb1ae3d82363bd3d"
        let latitude = 55.5
        let longitude =  37.5
        let host = "http://api.openweathermap.org"
        
        let  url = URL(string: "\(host)/data/2.5/find?lat=\(latitude)&lon=\(longitude)&cnt=10&appid=\(key)")
        
        guard let api = url else {
            return
        }
        
        URLSession.shared.dataTask(with: api) {
            data,response,error in
            if let error = error  {
                return
            }
            guard  let data = data else  {
                return
            }
            
            do {
               let temp =  try   JSONDecoder().decode(Root.self, from: data)
               completion(temp.list)
            }
            catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }

}
