//
//  WeatherData.swift
//  WeatherHiveSwift
//
//  Created by Aleksandr Tarabaka on 10.04.2020.
//  Copyright © 2020 Aleksandr Tarabaka. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
}

struct Current: Codable {
    let  dt: Double
    let temp: Double
    let feelsLike: Double
    let weather: [Weather]
    
    var date: Date {
        return Date(timeIntervalSince1970: dt)
    }
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        
        case dt
        case temp
        case weather
    }
}

struct Weather: Codable {
    let id: Int
    var image : String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

struct Hourly: Codable {
    let dt: Double
    let temp: Double
    let feelsLike: Double
    let weather: [Weather]
    
    var date: Date {
        return Date(timeIntervalSince1970: dt)
    }
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        
        case dt
        case temp
        case weather
    }
}

struct Daily: Codable, Identifiable {
    var id: String {
        return String(dt)
    }
    let dt: Double
    let temp : DailyTemp
    let feelsLike: DailyTemp
    let weather: [Weather]
    
    var date: Date {
        return Date(timeIntervalSince1970: dt)
    }
    
    var weekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        let currentDateString: String = dateFormatter.string(from: date)
        return currentDateString.uppercased()
        //let char = currentDateString[String.Index(utf16Offset: 0, in:currentDateString)]
        //let char = currentDateString[0...2]
        //return String(char)
    }
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        
        case dt
        case temp
        case weather
    }
}

struct DailyTemp: Codable {
    let day: Double
    let min: Double?
    let max: Double?
    let night: Double
    let eve: Double
    let morn: Double
}

struct WeatherDataName : Codable {
    let name: String
    let weather: [Weather]
}

