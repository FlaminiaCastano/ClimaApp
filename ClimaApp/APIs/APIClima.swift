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
            AF.request("http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=85ad76cb241ddd400e9c40d1b59c5f74&units=metric").responseDecodable(of: APIData.self){
                response in
                if let value = response.value {
                    let clima = value.weather
                    var descripcionDia: String = ""
                    for item in clima {
                        descripcionDia = item.weatherDescription
                    }
                    resolver.fulfill(descripcionDia)
                } else {
                    resolver.reject(APIError.ServerError)
                }
            }
            
        }
    }
    
    
    static func weatherPrimises(_ city: String) -> Promise<Clima> {
        return Promise { resolver in
            AF.request("http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=85ad76cb241ddd400e9c40d1b59c5f74&units=metric").responseDecodable(of: APIData.self){
                response in
                if let value = response.value {
                    let temperatura = value.main.temp
                    let maximo = value.main.tempMax
                    let minimo = value.main.tempMin
                    let clima = Clima(temp: temperatura, tempMax: maximo, tempMin: minimo)
                    resolver.fulfill(clima)
                } else {
                    resolver.reject(APIError.ServerError)
                }
            }
            
        }
    }
    
    
}
