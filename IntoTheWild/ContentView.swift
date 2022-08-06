//
//  ContentView.swift
//  IntoTheWild
//
//  Created by Junho Kim on 2022/08/06.
//

import SwiftUI

struct ContentView: View {
    
    private let locationProvider = LocationProvider()
    
    var body: some View {
        VStack{
            Text("Into The Wild.")
            Button("Set Home"){
                self.locationProvider.setHome()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
