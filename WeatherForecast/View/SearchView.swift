//
//  SearchView.swift
//  WeatherForecast
//
//  Created by Meriç on 7.05.2022.
//



import SwiftUI

struct SearchView: View {
    @StateObject var weatherVM: WeatherViewModel
    
    var body: some View {
        HStack {
            Button {
                weatherVM.getWeather()
            } label: {
                Image(systemName: "location.circle.fill").renderingMode(.original)
                    .font(.system(size: 24))
            }
            
            TextField("Search City", text: $weatherVM.searchedCityName, onCommit:  {
                weatherVM.fetchWeatherByCityName()
            })
            .padding(5)
            .background( Color(.quaternarySystemFill).opacity(1.4) )
            .cornerRadius(8)
            Button {
                weatherVM.fetchWeatherByCityName()
                hideKeyboard()
            } label: {
                Image(systemName: "magnifyingglass").renderingMode(.original)
                    .font(.system(size: 24))
                  
            }
        }
        .padding(.horizontal)
        .frame( maxWidth:350,alignment: .leading )
        .background(.ultraThinMaterial)
        .cornerRadius(55)
    }
}
