

import SwiftUI

@main
struct ForecastApp: App {
    
    // MARK: - Properties
    @StateObject var weatherVM = WeatherViewModel()
    
    // Alert Meaasage related to location Authorization status denied.
    private let message = NSLocalizedString("Go to Setting >> Privacy >> Location Services >> ForecastApp >> Ask Next Time", comment: "Location services are denied")
    private let settingsButtonTitle = NSLocalizedString("GO TO SETTINGS", comment: "Settings alert button")
    
    // MARK: - Root Window Body
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Bottom Most layer bacground color gradient.
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.3), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) ]), startPoint: .topLeading, endPoint: .bottomLeading).ignoresSafeArea()
         
                
                if weatherVM.isLoading {
                    // Loading indicator when app launches..
                    ProgressView("  ").font(.largeTitle)
                } else {
                    if weatherVM.showAlert {
                        ContentView()
                            // Alert on location denied.
                            .alert(isPresented: $weatherVM.showAlert) {
                                Alert(title: Text(NSLocalizedString("LOCATION SERVICES DENIED LAST TIME", comment: "Location services alert title")),
                                      message: Text(message),
                                      primaryButton: .default(Text(settingsButtonTitle)) {
                                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                            // Take the user to the Settings app to change permissions.
                                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                                        }
                                      },secondaryButton: .cancel()
                                )
                            }
                    } else {
                        ContentView()
                            // Alert when Network Error, Connection Error or API Key error etc.
                            .alert(item: $weatherVM.appError) { (appAlert) in
                                Alert(title: Text("Error"), message: Text(
                                        """
                                \(appAlert.errorString)
                                Please try again later.
                                """)
                                )
                            }
                    }
                }
            }
        }
    }
}
