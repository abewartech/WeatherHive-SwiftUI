//
//  WeekDay.swift
//  WeatherHiveSwift
//
//  Created by Aleksandr Tarabaka on 10.04.2020.
//  Copyright © 2020 Aleksandr Tarabaka. All rights reserved.
//

import SwiftUI

struct WeekDay: View {
    var day: String
    var temperature: Double
    
    var body: some View {
        VStack {
            Text(day)
                .font(.system(size:17))
                .foregroundColor(Color("text-dark"))
            HStack(spacing: 2) {
                Text(String(format:"%.0f", temperature ))
                    .font(.system(size:20))
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.3)
                    .foregroundColor(Color("text"))
                Text("°")
                    .font(.system(size:20))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("text"))
            }
        }
    }
}

struct WeekDay_Previews: PreviewProvider {
    static var previews: some View {
        WeekDay(day:"FRI", temperature: 22.6)
            .previewLayout(.fixed(width: 50, height: 100))
    }
}
