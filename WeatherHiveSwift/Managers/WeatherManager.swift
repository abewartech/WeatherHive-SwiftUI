//
//  WeatherFetcher.swift
//  WeatherHiveSwift
//
//  Created by Aleksandr Tarabaka on 10.04.2020.
//  Copyright © 2020 Aleksandr Tarabaka. All rights reserved.
//

import Foundation
import Combine

public class WeatherManager: ObservableObject {
    @Published var current : WeatherDataName?
    @Published var one : WeatherData?
    
    let weatherTodayURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid="
    let weatherOneURL = "https://api.openweathermap.org/data/2.5/onecall?units=metric&appid="
    let API_KEY = "YOURAPIKEY"
    
    func getWeather(latitude: Double, lontitude: Double)
    {
        loadCurrent(latitude: latitude, lontitude: lontitude)
        loadOne(latitude: latitude, lontitude: lontitude)
    }
    
    func loadCurrent(latitude: Double, lontitude: Double) {
        let urlString = "\(self.weatherTodayURL)\(API_KEY)&lat=\(latitude)&lon=\(lontitude)"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {(data,response,error) in
                do {
                    if let d = data {
                        let decodedLists = try JSONDecoder().decode(WeatherDataName.self, from: d)
                        DispatchQueue.main.async {
                            self.current = decodedLists
                        }
                    }else {
                        print("No Data")
                    }
                } catch {
                    print ("Error \(error)")
                }
                
            }.resume()
        }
    }
    
    func loadOne(latitude: Double, lontitude: Double) {
        let urlString = "\(self.weatherOneURL)\(API_KEY)&lat=\(latitude)&lon=\(lontitude)"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {(data,response,error) in
                do {
                    if let d = data {
                        let decodedLists = try JSONDecoder().decode(WeatherData.self, from: d)
                        DispatchQueue.main.async {
                            self.one = decodedLists
                        }
                    }else {
                        print("No Data")
                    }
                } catch {
                    print ("Error \(error)")
                }
                
            }.resume()
        }
    }
}
