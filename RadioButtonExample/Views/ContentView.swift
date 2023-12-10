//
//  ContentView.swift
//  RadioButtonExample
//
//  Created by softwave on 11/09/23.
//

import SwiftUI
import RadioButton

struct ContentView: View {
    
    @State private var cityVertical = City.milano
    @State private var cityHorizontal = City.milano
    
    var body: some View {
           VStack(spacing: 20) {
               //defaults to vertical
               RadioButton(title: "Cities: ",
                           itemTitle: \.rawValue,
                           isSelected: $cityVertical)


               RadioButton(alignment: .horizontal,
                           title: "Cities: ",
                           itemTitle: \.rawValue,
                           isSelected: $cityHorizontal)
           }
           .padding(20)
           .border(Color.gray)
       }
}

extension ContentView {
    enum City: String {
        case milano
        case roma
        case palermo
    }
}

extension ContentView.City: Identifiable {
    var id: RawValue {
        rawValue
    }
}

extension ContentView.City: CaseIterable {}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
