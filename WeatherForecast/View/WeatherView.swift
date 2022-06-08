//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Meriç on 7.05.2022.
//


import SwiftUI


struct WeatherView: View {
    @State var currentTab: Int = 0

    @StateObject var weatherVM = WeatherViewModel()
    var body: some View {
       
        if let daily = weatherVM.daily {

            ForEach(daily, id: \.dt) { day in

        VStack(alignment: .leading)
        {
            VStack
            {
                
                Spacer(minLength: 30)
                

                // search BAR
                SearchView(weatherVM: weatherVM)
                Spacer()
                // search BAR  Finish
                
                
                // current View
                VStack ( alignment: .leading )
                {
                    CurrentView(weatherVM:  weatherVM)
                    
                } // current View finish
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            // current ve search view in VStack Finish
            
            
            // hourly v stack(1)
            ScrollView
            {

                DetailView(weatherVM: weatherVM)
                
            } // hourly v stack finish
            .frame(width: 450, height: 322)
            .cornerRadius(90)
   
        }   .edgesIgnoringSafeArea(.all)
            
            // zstack finish
                .background(
                    LottieAnimationsView(jsonFile: day.weather[0].iconImage2 )
                        .frame( width: 1000, height: 1100 )
                    
                )
            
            }
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
