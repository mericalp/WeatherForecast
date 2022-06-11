
import SwiftUI

struct ContentView: View {
    
    // Property
    @StateObject var weatherVM = WeatherViewModel()
    
    //  Body
    var body: some View {
        if weatherVM.isLoading {
            ProgressView(" ").font(.largeTitle)
        } else {
            
            WeatherView(weatherVM: weatherVM)
            
        }
    }
}

//  Content Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
