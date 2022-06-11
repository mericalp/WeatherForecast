//
//  DetailView.swift
//  WeatherForecast
//
//  Created by Meriç on 7.05.2022.
//


import SwiftUI

struct DetailView: View {
    @State var currentTab: Int = 0

    @StateObject var weatherVM = WeatherViewModel()

    var body: some View {
        
  
        if let hourly = weatherVM.hourly {
    Spacer()
        Zstack
            {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.3), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.6), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
           
        VStack( alignment: .leading, spacing: 20 )
        {
            // HOURLY FORECAST DETAIL
           HStack
            {
                Spacer(minLength: 5)
                Text("Today").font(.system(size:20)).bold() .opacity(0.8)

            }.frame(width:80, height: 22 )
            Divider().frame(maxWidth: 450, maxHeight: 0.8)
                .background(Color(red: 234/255, green: 235/255, blue: 237/255))
            
               ScrollView(.horizontal, showsIndicators: false) {
                HStack
                {
                    ForEach(hourly, id: \.dt) { hour in
                        
                        ZStack
                        {
                            VStack {
                                Text(hour.dt.hourMinuteAmPm(weatherVM.timeZoneOffset)).font(.system(size:15)).bold() .opacity(0.9)
                                Spacer()
                             
                                Image(systemName: hour.weather[0].iconImage).renderingMode(.original).font(.system(size:25))

                                Spacer()
                                Text("\(hour.temp.roundedString(to: 0))°").font(.system(size:18)).bold() .opacity(0.9)
                               
                                .font(.system(size: 15))
                                .padding()
                              
                            }.padding()
                            .fixedSize()

                        }   .background(.ultraThinMaterial)
                            .cornerRadius(44)
                    }
                }
                }
            Divider().frame(maxWidth: 450, maxHeight: 0.8)
                .background(Color(red: 234/255, green: 235/255, blue: 237/255))
            
            // 8 DAY FORECAST DETAIL
            HStack
             {
                 Spacer(minLength: 15)
                 Text("8-Day Forecast ").font(.system(size:20)).bold() .opacity(0.8)

             }.frame(width:166, height: 22 )
            
            VStack
            {
                Divider().frame(maxWidth: 450, maxHeight: 0.8)
                    .background(Color(red: 234/255, green: 235/255, blue: 237/255)).opacity(4)
                
            if let daily = weatherVM.daily {
                
            // DETAIL SCROLL VIEW
            ScrollView(.horizontal, showsIndicators: false) {
             VStack
             {
                 ForEach(daily, id: \.dt) { day in


                         HStack {

                             VStack
                             {
                                 Spacer(minLength:20)
                                 Text( day.dt.dayDateMonth).font(.system(size:20)).bold()
                                 .opacity(0.9).multilineTextAlignment(.center   )
                                 
                             }.fixedSize()
                                 .frame(width: 5, height: 300 )
                             Spacer(minLength:120)
                             
                             VStack
                             {
                                 Spacer(minLength:30)
                            Image(systemName: day.weather[0].iconImage).renderingMode(.original).font(.system(size:25)).multilineTextAlignment(.center   )
                                     // LottieAnimationsView(jsonFile: day.weather[0].iconImage2)
                                  // .frame(width: 50, height: 50 )
                             }.fixedSize()
                                 .frame(width: 5, height: 300 )
                             Spacer(minLength:90)
                             
                             VStack
                             {   Spacer(minLength:30)
                                 HStack
                                 {
                                     Image(systemName: "thermometer").font(.system(size: 25))
                                     Text("\(day.temp.min.roundedString(to: 0))°")
                                     .font(.system(size:20)).bold()
                                     .opacity(0.9).multilineTextAlignment(.center   )
                                     .padding()
                                     Spacer(minLength: 5)
                                 }
                            
                             }.fixedSize()
                                 .frame(width: 40, height: 300 )
                             Spacer(minLength:10)
                             
                             VStack
                             {   Spacer(minLength:30)
                                 HStack
                                 {
                                     Text("\(day.temp.max.roundedString(to: 0))°").font(.system(size:20)).bold()
                                         .opacity(0.9).multilineTextAlignment(.center   )
                                 }
  
                             }.fixedSize()
                                 .frame(width:40, height: 300 )
                        
                             
                         }.padding()
                         .fixedSize()
                         .frame(width:400, height: 50 )

                     
                 }
             }
             }
            }
            }
            if let current = weatherVM.current {
                Divider().frame(maxWidth: 450, maxHeight: 0.8)
                    .background(Color(red: 234/255, green: 235/255, blue: 237/255))
                
                    //   DETAIL
                    VStack {
                        // SUNRISE-SET  ANIMATIONS
                        LottieAnimationsView(jsonFile: "sunrise-sunset")
                            .frame(width: 400, height : 200 )
                        HStack {
                            Text (current.sunrise.hourMinuteAmPm(weatherVM.timeZoneOffset) ).bold().opacity(0.7)
                            Spacer(minLength:80)
                            Text (current.sunset.hourMinuteAmPm(weatherVM.timeZoneOffset) ).bold().opacity(0.7)
                            
                        }.frame(width: 340, height: 100 )
                        
                        Spacer(minLength: 20)
                        
                        // LINE 1
                        HStack {
                            Spacer(minLength: 20)

                            // CLOUD DETAIL
                            HStack
                                {
                                    VStack(alignment: .leading)
                                    {
                                        HStack
                                        {
                                        
                                     
                                        Image(systemName: "cloud.fill").opacity(0.7)
                                        Text("CLOUD").font(.system(size: 15)).bold().opacity(0.7)
                                        }
                                        Spacer(minLength: 11)
                                        VStack
                                        {
                                            Image(systemName: "cloud.fill").opacity(0.7)
                                                .frame(width: 90, height: 90)
                                                .font(.system(size: 60))
                                            HStack
                                            {
                                                Text(" \((current.clouds))%").font(.system(size: 20)).bold().opacity(0.7)
                                            }
                                        }.frame(width: 170, height: 110 )
          
                                    }.frame(width: 170, height: 130 )

                                }.frame(width:165, height: 160 )
                                    .background(.ultraThinMaterial)
                                            .cornerRadius(20)

                            Spacer(minLength: 10)
                        
                            // HUMIDITY DETAIL
                                 HStack
                                     {
                                         VStack(alignment: .leading)
                                         {
                                             HStack
                                             {
                                             Image(systemName: "humidity.fill").opacity(0.7)
                                             Text("HUMIDITY ").bold().opacity(0.6)
                                             }
                                             Spacer(minLength: 11)
                                             VStack
                                             {
                                                 LottieAnimationsView(jsonFile: "hum")
                                                     .frame(width: 90, height: 90)
                                                 Text("\(current.humidity)%").font(.system(size: 20)).bold().opacity(0.7)
                                                 
                                             }.frame(width: 170, height: 110 )
                                               
                                         }.frame(width: 170, height: 130 )
                                         
                                     }.frame(width:165, height: 160 )
                                         .background(.ultraThinMaterial)
                                                 .cornerRadius(20)
                  
                        }.frame(width: 380, height: 100 )
                        
                        Spacer(minLength: 100)
                        
                        // LINE 2
                        HStack {
                            Spacer(minLength: 20)
                            
                        // WIND DETAIL
                        HStack
                            {
                                VStack(alignment: .leading)
                                {
                                    HStack
                                    {
                                    
                                 
                                    Image(systemName: "wind")
                                    Text("WIND ").bold().opacity(0.6)
                                    }
                                    Spacer(minLength: 11)
                                    VStack
                                    {
                                        LottieAnimationsView(jsonFile: "compass")
                                            .frame(width: 90, height: 90)
                                        Text(current.windSpeedWithDirection).bold().opacity(0.7).font(.system(size: 18))
                                    }.frame(width: 170, height: 110 )
                                      
                                }.frame(width: 170, height: 130 )
                                   
                            
                            }.frame(width: 165, height: 160 )
                                .background(.ultraThinMaterial)
                                        .cornerRadius(20)
                
                            Spacer(minLength: 10)
                            
                            // UV LIGHT DETAIL
                            HStack
                                {
                                    VStack(alignment: .leading)
                                    {
                                        HStack
                                        {
                                        
                                     
                                        Image(systemName: "sun.max.fill").opacity(0.6)
                                        Text("UV ").bold().opacity(0.6)
                                        }
                                        Spacer(minLength: 11)
                                        VStack
                                        {
                                            LottieAnimationsView(jsonFile: "sunnn")
                                                .frame(width: 90, height: 90)
                                            HStack
                                            {
                                                Text(current.uvi.roundedString(to: 0)).bold().opacity(0.7).font(.system(size: 18))
                                                Text("Low").bold().opacity(0.7).font(.system(size: 18))
                                            }
                                           
                                        }.frame(width: 170, height: 110 )
                                          
                                    }.frame(width: 170, height: 130 )
                                       
                                
                                }.frame(width: 165, height: 160 )
                                    .background(.ultraThinMaterial)
                                            .cornerRadius(20)

                        }.frame(width: 380, height: 100 )
                        
                        Spacer(minLength: 100)
                        
                        // LINE 3
                        HStack {
                            Spacer(minLength: 20)
                            
                            // VISIBILITY DETAIL
                            HStack
                                {
                                    VStack(alignment: .leading)
                                    {
                                        HStack
                                        {
                                        
                                     
                                        Image(systemName: "eye")
                                        Text("VISIBILITY ").bold().opacity(0.6)
                                        }
                                        Spacer(minLength: 11)
                                        VStack
                                        {
                                            LottieAnimationsView(jsonFile: "visi")
                                                .frame(width: 90, height: 90)
                                            HStack
                                            {
                                                Text(" \(current.visibility/1000) Km").bold().opacity(0.7).font(.system(size: 20))
                                            }
                                        }.frame(width: 170, height: 110 )
                                          
                                    }.frame(width: 160, height: 130 )
                                       
                                }.frame(width: 165, height: 160 )
                                    .background(.ultraThinMaterial)
                                            .cornerRadius(20)
             
                            Spacer(minLength: 10)
                        
                            // PRESSURE DETAIL
                                 HStack
                                {
                                    /*
                                     LinearGradient(colors: [Color.red,Color.blue], startPoint: .top, endPoint: .bottom)
                                    .ignoresSafeArea()
                                     */
                    
                                         VStack(alignment: .leading)
                                         {
                                             HStack
                                             {
                                             Image(systemName: "timer.square")
                                             Text("PRESSURE ").bold().opacity(0.6)
                                             }
                                             Spacer(minLength: 11)
                                             VStack
                                             {
                                                 Text("NORMAL").bold().opacity(0.7).frame(width: 90, height: 90 )
                                                 Text("\(current.pressure) hPa").bold().opacity(0.7).font(.system(size: 20))
                                             }.frame(width: 170, height: 110 )
                                               
                                         }.frame(width: 170, height: 130 )
                                            
                                     }.frame(width: 165, height: 160 )
                                         .background(.ultraThinMaterial)
                                                 .cornerRadius(20)
                        }.frame(width: 380, height: 100 )
                    }
            }
        // DETAIL FINISH
        }
        .frame(maxWidth: 440, alignment: .leading)
        .padding()
        .padding(.bottom, 20)
        .foregroundColor(Color.black.opacity(0.8))
        .background(Color(red: 112/255, green: 175/255, blue: 206/255))
        .cornerRadius(55)
            }
        }
    }
}

