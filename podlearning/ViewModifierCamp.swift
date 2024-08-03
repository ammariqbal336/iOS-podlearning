//
//  ViewModifierCamp.swift
//  podlearning
//
//  Created by mac on 02/08/2024.
//

import SwiftUI


struct DefaultViewModifier : ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(backgroundColor)
            .cornerRadius(20)
            .padding()
    }
    
}

extension View {
    func withDefaultButtonViewModifier(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultViewModifier(backgroundColor: backgroundColor))
    }
}


struct ViewModifierCamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .withDefaultButtonViewModifier(backgroundColor: .red)
           
        
        Text("Hello, World!")
            .withDefaultButtonViewModifier(backgroundColor: .green)
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .withDefaultButtonViewModifier()
            
            
    }
}

#Preview {
    ViewModifierCamp()
}
