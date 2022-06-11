//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Meriç on 15.05.2022.
//



import SwiftUI
import CoreLocation

final class WeatherViewModel: NSObject, ObservableObject {
   
   
    @Published var showAlert = false
    @Published var isLoading = true
    @Published var appError: AppError? = nil
    
    @Published var searchedCityName = ""
    @Published var currentCityName = ""
    @Published var timeZoneOffset = 0
    
    @Published var current: WeatherDataModel.Current?
    @Published var daily: [WeatherDataModel.Daily]?
    @Published var hourly: [WeatherDataModel.Hourly]?
    @Published var weather: [WeatherDataModel.Weather]?

    // API SERVICE VARIABLE
    let apiService = APIService.shared
    // LOCATION MANAGER
    let locationManager = CLLocationManager()
        

    
   
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // request When In Use Authorization
        requestLocation()
    }
    
     
    func getWeather() {
        if let location = locationManager.location {
            performWeatherRequest(with: location)
        }
    }
    
    func fetchWeatherByCityName() {
        if searchedCityName != "" {
            CLGeocoder().geocodeAddressString(searchedCityName) { (placemarks, error) in
                if let location = placemarks?.first?.location {
                    self.performWeatherRequest(with: location)
                }
            }
        }
    }
    
    
    //  Perform Weather Request
    func performWeatherRequest(with location: CLLocation) {
        API.checkForAPIKey()
        let coordinate = location.coordinate
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&exclude=minutely,alerts&appid=\(API.key)&units=metric"
        apiService.getJSON(urlString: urlString) { (result: Result<WeatherDataModel, APIService.APIError>) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async { [weak self] in
                    self?.timeZoneOffset = result.timezone_offset
                    self?.current = result.current
                    self?.daily = result.daily
                    self?.hourly = result.hourly
                    self?.getCityName(of: location)
                    self?.isLoading = false
                    self?.searchedCityName = ""
                }
            case .failure(let apiError):
                print("mansaError: \(apiError.localizedDescription)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.appError = AppError(errorString: "\(result)")
                }
            }
        }
    }
    //
    func getCityName(of location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first {
                self.currentCityName = "\(placemark.locality ?? "") \(placemark.country ?? "")"
            }
        }
    }
    
    /*
    func xxx( ) -> LottieAnimationsView {
    
        if hourly![0].weather[0].iconImage == "sun.max.fill" {
            return  LottieAnimationsView(jsonFile: "yaz")
                
        }
        else if hourly![0].weather[0].iconImage == "smoke.fill"
        {
         return    LottieAnimationsView(jsonFile: "cloudy")
                        
        }
        else
        {
            return    LottieAnimationsView(jsonFile: "snow")
     
        }
  
    */
 
}

//  CLLocationManagerDelegate
extension WeatherViewModel: CLLocationManagerDelegate {
    
    // Changed Authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocation()
    }
    // Location Request
    private func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        switch locationAuthorizationStatus() {
        case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // gets the best location but eats a lot of battery
            locationManager.requestLocation()
        case .restricted: break
        case .denied: showAlert = true; isLoading = false
        @unknown default: break
        }
    }
    // Location Status
    func locationAuthorizationStatus() -> CLAuthorizationStatus {
        let locationManager = CLLocationManager()
        var locationAuthorizationStatus : CLAuthorizationStatus
        if #available(macCatalyst 14.0, *), #available(iOS 14.0, *) {
            locationAuthorizationStatus =  locationManager.authorizationStatus
        } else {
            
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        return locationAuthorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.isLoading = false
        print(error.localizedDescription)
    }
   


}
    
 
