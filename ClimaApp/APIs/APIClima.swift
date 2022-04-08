//
//  APIClima.swift
//  ClimaApp
//
//  Created by Flaminia Castaño on 08/04/2022.
//

import Foundation

import Alamofire
import PromiseKit

class APIClima{
    
    static func descriptionDayPromises(_ city: String) -> Promise<String> {
        return Promise { resolver in
            AF.request("http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=85ad76cb241ddd400e9c40d1b59c5f74&units=metric")
                .responseDecodable(of: APIData.self) {
                    response in
                    if let value = response.value {
                        let weather = value.weather
                        var descriptionDay: String = ""
                        for item in weather {
                            descriptionDay = item.weatherDescription
                        }
                        resolver.fulfill(descriptionDay)
                    } else {
                        resolver.reject(APIError.ServerError)
                    }
                }
        }
    }
    
    static func weatherPromises(_ city: String) -> Promise<Clima> {
        return Promise { resolver in
            AF.request("http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=85ad76cb241ddd400e9c40d1b59c5f74&units=metric")
                .responseDecodable(of: APIData.self) {
                    response in
                    if let value = response.value {
                        let temp = value.main.temp
                        let max = value.main.tempMax
                        let min = value.main.tempMin
                        let weather = Clima(temp: temp, tempMax: max, tempMin: min)
                        resolver.fulfill(weather)
                    } else {
                        resolver.reject(APIError.ServerError)
                    }
                }
        }
    }
    
    
}
