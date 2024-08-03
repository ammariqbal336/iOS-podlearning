//
//  ButtonStyleCamp.swift
//  podlearning
//
//  Created by mac on 03/08/2024.
//

import SwiftUI

struct PressButtonStyle : ButtonStyle {
   
    let scaledValue : CGFloat
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledValue : 1.0)
            //.brightness(configuration.isPressed ? 0.1: 0)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

extension View {
    func withPressableStyle(scaledValue: CGFloat = 0.9) -> some View {
        buttonStyle(PressButtonStyle(scaledValue: scaledValue))
    }
}

struct ButtonStyleCamp: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Click")
                .withDefaultButtonViewModifier()
                
                
        }
        .withPressableStyle(scaledValue: 0.9)
        .padding()

    }
}

#Preview {
    ButtonStyleCamp()
}
