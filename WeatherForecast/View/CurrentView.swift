//
//  CurrentView.swift
//  WeatherForecast
//
//  Created by Meriç on 7.05.2022.
//


import SwiftUI

struct CurrentView: View {
    @StateObject var weatherVM: WeatherViewModel

    var body: some View {
        if let current = weatherVM.current {
            
            HStack
            {
                Image(systemName: "mappin").foregroundColor(Color.red)
                VStack(alignment: .center)
                {
                    Text(weatherVM.currentCityName).fontWeight(.thin).bold().opacity(0.7)
                        .font(.system(size: 35))
                        .multilineTextAlignment(.center)
                    Text("\(current.feels_like.roundedString(to: 0))°").font(.system(size: 65)).fontWeight(.thin).bold().opacity(0.7)
                    HStack
                    {
                        Spacer(minLength: 13)
                    Image(systemName: "cloud.fill").opacity(0.7)
                        Text("\((current.clouds))%").opacity(0.7).font(.system(size: 18))
                        Spacer(minLength: 25)
                    

                    Image(systemName: "humidity.fill").opacity(0.7).font(.system(size: 18))
                    Text("\(current.humidity)%").opacity(0.7).font(.system(size: 18))
                        Spacer(minLength: 19)
                        
                    }.frame(width: 370, height: 22 )
                }
                .padding()
            }
           HStack
            {     
            }.fixedSize()
            Spacer()
        }
    }
}
