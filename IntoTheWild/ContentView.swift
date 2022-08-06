//
//  ContentView.swift
//  IntoTheWild
//
//  Created by Junho Kim on 2022/08/06.
//

import SwiftUI

struct ContentView: View {
    
    //private let locationProvider = LocationProvider()
    @EnvironmentObject private var locationProvider: LocationProvider
    
    var body: some View {
        VStack{
            Text("Into The Wild.")
            Button("Set Home"){
                self.locationProvider.setHome()
            }
            HStack(alignment: .bottom, spacing: 2) {
                ForEach(self.locationProvider.dayEntries, id: \.self){
                    value in DayEntryView(duration: value.duration,
                                          max: self.locationProvider.max,
                                          weekday: value.weekday)
                }
            }.padding()
        }.background(Color(UIColor.systemBackground))
            .alert(isPresented: $locationProvider.wrongAuthorization) {
            Alert(title: Text("Not authorized"), message: Text("Open setting and authorize."),
                  primaryButton: .default(Text("Settings"), action:{
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }), secondaryButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var locationProvider: LocationProvider = {
        let locationProvider = LocationProvider()
        locationProvider.dayEntries = [
            DayEntry(duration: 20640, weekday: "Monday"),
            DayEntry(duration: 2580, weekday: "Tuesday"),
            DayEntry(duration: 12000, weekday: "Wednesday"),
            DayEntry(duration: 1200, weekday: "Thursday"),
            DayEntry(duration: 2200, weekday: "Friday"),
            DayEntry(duration: 19920, weekday: "Saturday"),
            DayEntry(duration: 18000, weekday: "Sunday"),
        ]
        return locationProvider
    }()
    
    static var previews: some View {
        Group{
            ContentView().environmentObject(locationProvider)
            ContentView().environmentObject(locationProvider).environment(\.colorScheme, .dark)
        }
    }
}
