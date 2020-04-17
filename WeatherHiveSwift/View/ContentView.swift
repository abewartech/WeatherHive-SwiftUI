//
//  ContentView.swift
//  WeatherHiveSwift
//
//  Created by Aleksandr Tarabaka on 10.04.2020.
//  Copyright © 2020 Aleksandr Tarabaka. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var lm = LocationManager()
    @ObservedObject var wm = WeatherManager();
    
    var latitude: Double  { return lm.location?.latitude ?? 0}
    var longitude: Double { return lm.location?.longitude ?? 0 }
    var daily: [Daily] {
        return wm.one?.daily ?? [Daily]()
    }
    var tomorrowTemp: String {
        var temperature = "0"
        if let days = wm.one?.daily {
            var dayComponent    = DateComponents()
            dayComponent.day    = 1
            let nextDate = Calendar.current.date(byAdding: dayComponent, to: (wm.one?.current.date)!)
            
            for d in days {
                let order = Calendar.current.compare(d.date, to: nextDate!, toGranularity: .day)
                
                if order == .orderedSame {
                    temperature = String(format: "%.0f", d.temp.day)
                    
                }
            }
        }
        return temperature
    }
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack{
                    Text("\(wm.current?.name ?? "-")")
                        .font(.largeTitle)
                        .foregroundColor(Color("text"))
                        .multilineTextAlignment(.center)
                    
                    Text("Today")
                        .font(.system(size: 20))
                        .foregroundColor(Color("text"))
                }
                Spacer()
                Image(systemName: wm.current?.weather[0].image ?? "thermometer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90, alignment: .center)
                Spacer()
                HStack {
                    Text(String(format:"%.0f", wm.one?.current.temp ?? 0))
                        .font(.system(size:100))
                        .fontWeight(.bold)
                        .foregroundColor(Color("text"))
                    Text("°")
                        .font(.system(size:100))
                        .fontWeight(.bold)
                        .foregroundColor(Color("text"))
                }
                Spacer()
                
                Text("Tomorrow")
                    .font(.system(size: 20))
                    .foregroundColor(Color("text"))
                HStack(spacing: 1) {
                    Image(systemName: "cloud.sun")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40, alignment: .center)
                        .padding(.horizontal)
                    Text(tomorrowTemp)
                        .font(.system(size:28))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("text"))
                        .minimumScaleFactor(0.3)
                    Text("°")
                        .font(.system(size:28))
                        .fontWeight(.bold)
                        .foregroundColor(Color("text"))
                }
                Spacer()
                if !daily.isEmpty {
                    HStack(spacing: 12 ){
                        ForEach(daily){ day in
                            WeekDay(day: day.weekDay, temperature: day.temp.day)
                        }
                    }
                }else{
                    Rectangle()
                        .fill(Color("background"))
                        .frame(width: 50, height: 50)
                }
            }
        }
        .onAppear {
            self.wm.getWeather(latitude: self.latitude, lontitude: self.longitude)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
