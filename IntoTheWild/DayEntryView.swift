//
//  DayEntryView.swift
//  IntoTheWild
//
//  Created by Junho Kim on 2022/08/07.
//

import SwiftUI

struct DayEntryView: View {
    let duration: TimeInterval
    let max: TimeInterval
    let weekday: String
    
    var body: some View {
        VStack{
        GeometryReader{
            geometry in
            VStack{
                Spacer(minLength: 0)
                ZStack(alignment: .top) {
                Rectangle().frame(height: geometry.size.height*CGFloat(self.duration/self.max))
                    if self.duration > 0 {
                        Text(self.durationString(from: self.duration)).foregroundColor(Color("durationTextColor")).font(.footnote)
                    }
                }
            }
            Text(String(self.weekday.first ?? " "))
        }
        }
    }
    
    func durationString(from duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        
        return formatter.string(from: duration) ?? ""
    }
}

struct DayEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        DayEntryView(duration: 120, max: 240, weekday: "Friday")
            DayEntryView(duration: 20640, max: 30000, weekday: "Tuesday").background(Color(UIColor.systemBackground)).environment(\.colorScheme, .dark)
            
        }
    }
}
