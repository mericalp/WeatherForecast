//
//  AppError.swift
//  WeatherForecast
//
//  Created by Meriç on 10.05.2022.
//

import Foundation

struct AppError: Identifiable {
    
    // MARK: - Properties
    let id = UUID().uuidString
    let errorString: String
}
