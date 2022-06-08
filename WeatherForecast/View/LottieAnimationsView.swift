//
//  LottieAnimationsView.swift
//  Forecast
//
//  Created by Meriç on 30.05.2022.
//

import SwiftUI
import Lottie

struct LottieAnimationsView: UIViewRepresentable {
    
    var jsonFile : String

    
    
   func makeUIView(context: Context) -> UIView {
        
        let rootView = UIView()
        rootView.backgroundColor = .clear
        
      let animationView = AnimationView (name: jsonFile,bundle: .main)

       animationView.backgroundColor = .clear
       animationView.loopMode = .loop
       animationView.play()
        
       animationView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintss =  [
      
            animationView.widthAnchor.constraint(equalTo: rootView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: rootView.heightAnchor ),
        ]
        
       rootView.addSubview(animationView)
        rootView.addConstraints(constraintss)

        return rootView

    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
            
    }
    
    
}
