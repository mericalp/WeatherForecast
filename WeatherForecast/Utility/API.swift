//
//  API.swift
//  WeatherForecast
//
//  Created by Meriç on 10.05.2022.
//

import Foundation

struct API {
    static let key = "6b0f9abfd032ccca32d2eba6fab78445"
    
    static func checkForAPIKey() {
        precondition(API.key != "YourAPIKey", "Condition: \nEither your APIKey is invalid or you haven't filled it yet. \nPlease Fill Your APIKey")
    }
}

