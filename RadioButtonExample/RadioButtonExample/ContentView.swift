//
//  ContentView.swift
//  RadioButtonExample
//
//  Created by softwave on 11/09/23.
//

import SwiftUI
import RadioButton

struct ContentView: View {
    
    @State private var city = City.milano
    
    var body: some View {
        RadioButton(title: "Cities: ",
                    itemTitle: \.rawValue,
                    isSelected: $city)
        .padding()
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
