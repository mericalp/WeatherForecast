//
//  UIAppExtension.swift
//  WeatherForecast
//
//  Created by Meriç on 8.05.2022.
//


import SwiftUI

#if canImport(UIKit)
extension View {
    // 
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
#endif
