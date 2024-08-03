//
//  SDWebImageLoader.swift
//  podlearning
//
//  Created by mac on 31/07/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct SDWebImageLoader: View {
    let url :String
    var contentMode: ContentMode = .fill
    
    var body: some View {
        WebImage(url: URL(string: url)) { image in
               image.resizable() // Control layout like SwiftUI.AsyncImage, you must use this modifier or the view will use the image bitmap size
           } placeholder: {
                   Rectangle().foregroundColor(.gray)
           }
            .onSuccess { image, data, cacheType in
                    // Success
                    // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                }
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .aspectRatio(contentMode: contentMode)
                .frame(width: 300, height: 300, alignment: .center)
    }
}

//#Preview {
//    SDWebImageLoader(url: <#T##String#>)
//}
