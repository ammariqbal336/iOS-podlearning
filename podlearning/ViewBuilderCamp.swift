//
//  ViewBuilderCamp.swift
//  podlearning
//
//  Created by mac on 03/08/2024.
//

import SwiftUI

struct HeaderView<CustomView: View> : View {
    let content: CustomView
    
    init(@ViewBuilder content:() -> CustomView) {
        self.content = content()
    }
    
    var body: some View{
        VStack {
            Text ("Hi")
            content
        }
        
        
    }
}

struct ViewBuilderCamp: View {
    var body: some View {
        HeaderView {
            Text("Ammr")
        }
    }
}

#Preview {
    ViewBuilderCamp()
}
