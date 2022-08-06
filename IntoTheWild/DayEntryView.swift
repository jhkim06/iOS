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
        }.accessibilityElement(children: .ignore).accessibility(label: Text(voiceOverGroupString(for: duration)))
    }
    
    func durationString(from duration: TimeInterval, forVoiceOver: Bool = false) -> String {
        
        if duration < 1 {
            return "no time outside"
        }
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        
        if forVoiceOver {
            formatter.unitsStyle = .full
        }else {
            formatter.unitsStyle = .abbreviated
        }
        
        return formatter.string(from: duration) ?? ""
    }
    func voiceOverGroupString(for duration: TimeInterval)-> String{
        let duration = durationString(from: duration, forVoiceOver: true)
        return "\(duration) on \(weekday)"
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
