//
//  SDWebImageBootcamp.swift
//  podlearning
//
//  Created by mac on 31/07/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct SDWebImageBootcamp: View {
    var body: some View {
       SDWebImageLoader(url: "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic",
                        contentMode: .fit)
       .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
       .cornerRadius(20)
    }
}

#Preview {
    SDWebImageBootcamp()
}
