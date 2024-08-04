//
//  PreferenceKeyCamp.swift
//  podlearning
//
//  Created by mac on 04/08/2024.
//

import SwiftUI

struct PreferenceKeyCamp: View {
    
    @State var valueString : String = ""
    var body: some View {
        ChildView(text: valueString)
            .onPreferenceChange(PreferenceUpdateValue.self, perform: { value in
                valueString = value
            })
    }
}

#Preview {
    PreferenceKeyCamp()
}

extension View {
    
    func CustomValue(_ text: String) -> some View {
        preference(key:PreferenceUpdateValue.self, value: text)
    }
}


struct ChildView : View {
    
    let  text :String
    var body: some View {
        Text(text)
            .CustomValue("Check Value")
            
    }
}

struct PreferenceUpdateValue : PreferenceKey {

        static var defaultValue: String = ""
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
    
}
