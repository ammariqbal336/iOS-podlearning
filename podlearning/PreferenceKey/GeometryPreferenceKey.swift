//
//  GeometryPreferenceKey.swift
//  podlearning
//
//  Created by mac on 04/08/2024.
//

import SwiftUI

struct GeometryPreferenceKey: View {
    @State private var size : CGSize = .zero
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: size.width, height: size.height)
                .background(.red)
               
            
            Spacer()
            HStack {
                Rectangle()
                GeometryReader{ geometry in
                    Rectangle()
                        .preference(key: RectanglePreferenceKey.self, value: geometry.size)
                }
                
                
                Rectangle()
            }
            .frame(height: 55)
        }
        
        .onPreferenceChange(RectanglePreferenceKey.self, perform: { value in
            self.size = value
        })
    }
}

#Preview {
    GeometryPreferenceKey()
}

extension View {
    func geometryPreference(size: CGSize) -> some View {
        preference(key: RectanglePreferenceKey.self, value: size)
    }
}


struct RectanglePreferenceKey : PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
