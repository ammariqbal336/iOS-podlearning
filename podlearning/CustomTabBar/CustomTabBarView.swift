//
//  CustomTabBarView.swift
//  podlearning
//
//  Created by mac on 06/08/2024.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selected: TabBarItem
    let tabItems : [TabBarItem]
//    = [
//        TabBarItem(iconImage: "house", tabName: "Home", tabColor: .red),
//        TabBarItem(iconImage: "heart", tabName: "Favorite", tabColor: .blue),
//        TabBarItem(iconImage: "person", tabName: "Profile", tabColor: .yellow)
//    ]
    var body: some View {
       Spacer()
        HStack {
            ForEach(tabItems, id: \.self) { tabItem in
                tabView(tab: tabItem)
                    .onTapGesture {
                        switchTab(tab: tabItem)
                    }
            }
            
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges:.bottom))
    }
}

extension CustomTabBarView {
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconImage)
                .font(.subheadline)
            Text(tab.tabName)
                .font(.system(size: 10,weight: .semibold,design: .rounded))
                
        }
        .foregroundColor(selected == tab ? tab.tabColor : .gray)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(selected == tab ? tab.tabColor.opacity(0.2) : .clear )
        .cornerRadius(10)
    }
    
    private func switchTab(tab: TabBarItem) {
        withAnimation(.easeOut) {
            selected = tab
        }
    }
}

//#Preview {
//    CustomTabBarView(selected: .constant(tabItems.first), tabItems: tabItems)
//}
struct TabBarItem : Hashable {
    
    let iconImage: String
    let tabName: String
    let tabColor: Color
}


