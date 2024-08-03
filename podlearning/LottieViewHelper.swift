//
//  LottieViewHelper.swift
//  podlearning
//
//  Created by mac on 01/08/2024.
//

import SwiftUI
import Lottie
struct LottieViewHelper: View {
    var body: some View {
        LottieView(animation: .named("logo"))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
    }
}

#Preview {
    LottieViewHelper()
}
