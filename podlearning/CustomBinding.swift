//
//  CustomBinding.swift
//  podlearning
//
//  Created by mac on 19/08/2024.
//

import SwiftUI

extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }

    }
}

struct CustomBinding: View {
    @State private var errorMsg: String?
   // @State private var showAlert: Bool = false
    
    @State private var title :String = "Ammar"
    var body: some View {
        VStack {
            Text("\(title) Parent")
                .onTapGesture {
                     errorMsg = "Error Detail"
                   // showAlert.toggle()
                }
            ChildView1(title: $title)
            ChildView2(title: $title)
        
        }
        .alert(errorMsg ?? "Error", isPresented: Binding(value: $errorMsg)) {
            Button(action: {
                //errorMsg
                //showAlert.toggle()
            }, label: {
                Text("OK")
            })
            
            
        }
    }
}

struct ChildView1 : View {
    @Binding var title: String
    var body: some View {
        Text(title)
            .onAppear {
                title = "OK"
            }
    }
}

struct ChildView2 : View {
    let title: Binding<String>
    var body: some View {
        Text(title.wrappedValue)
            .onAppear {
                title.wrappedValue = "OK 22"
            }
    }
}

//#Preview {
//    CustomBinding()
//}
