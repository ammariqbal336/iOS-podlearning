//
//  MatchedGeometryCamp.swift
//  podlearning
//
//  Created by mac on 05/08/2024.
//

import SwiftUI

struct MatchedGeometryCamp: View {
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    var body: some View {
        VStack {
            if !isClicked {
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100,height: 100)
                    
            }
            
            Spacer()
            if isClicked {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300,height: 300)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            withAnimation(.easeOut) {
                isClicked.toggle()
            }
            
        }
    }
}

#Preview {
    MatchedGeometryEffect()
}

struct MatchedGeometryEffect : View {
    
    @State private var categories: [String] = ["Home","Popular","Profile"]
    @State private var isSelected : String = ""
    @Namespace private var namespace2
    var body: some View {
        HStack {
            ForEach(categories
                    , id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if isSelected == category {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.red)
                            .matchedGeometryEffect(id: "tabbar", in: namespace2)
                            .frame(width: 35,height: 2)
                            .offset(y: 10)
                        
                            
                    }
                        
                    Text(category)
                        .foregroundColor(isSelected == category ? .red : .black)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()){
                        isSelected = category
                    }
                }
                
               
            }
          
        }
       
    }
}
