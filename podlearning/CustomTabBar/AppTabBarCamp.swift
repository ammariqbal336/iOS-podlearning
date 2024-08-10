//
//  AppTabBarCamp.swift
//  podlearning
//
//  Created by mac on 06/08/2024.
//

import SwiftUI

struct AppTabBarCamp: View {
    
    var tabItems = [
            TabBarItem(iconImage: "house", tabName: "Home", tabColor: .red),
            TabBarItem(iconImage: "heart", tabName: "Favorite", tabColor: .blue),
            TabBarItem(iconImage: "person", tabName: "Profile", tabColor: .yellow)
        ]
   
    var body: some View {
        Text("")
//        CustomTabBarView(selected: tabItems[0], tabItems: tabItems)
    }
}

#Preview {
    AppTabBarCamp()
}
