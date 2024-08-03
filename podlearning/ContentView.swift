//
//  ContentView.swift
//  podlearning
//
//  Created by mac on 30/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var stack : [String] = []
    var home: String = "home"

    var body: some View {
        
        NavigationStack(path: $stack) {
            VStack {
                CustomView(url: "https://picsum.photos/400")
            }
            .navigationDestination(for: String.self) { value in
                CustomView(url: value)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            stack.append("https://picsum.photos/400")
                        }
                        
                }
                ToolbarItem(placement: .principal) {
                    Text("Picture World")
                        .bold()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.title)
                        .onTapGesture {
                            stack.append("ok")
                        }
                }
                
            }
           
            
            
        }
    }
}
    
    #Preview {
        ContentView()
    }
    
    
struct CustomView : View {
    var url :String
    @AppStorage("title") var title: String?
        @AppStorage("count") var countValue: Int?
        private var data = Array(1...20)
        private let adaptiveColumn = [
            GridItem(.adaptive(minimum: 150))
        ]
        
    init (url: String){
        self.url = url
    }
        var body: some View {
            //                if let titleinfo = title   {
            //                        Text("\(title ?? "") \(countValue ?? 0)")
            //                            .font(.title)
            //                            .bold()
            //
            //                }
                           
                            ScrollView{
                                LazyVGrid(columns:adaptiveColumn, content: {
                                    
                                    ForEach(data,id: \.self) { item in
                                        
                                        var url = URL(string:url)
                                        if #available(iOS 15.0, *) {
                                            AsyncImage(url: url) { displayImage in
                                                displayImage
                                                    .resizable()
                                                    .scaledToFit()
                                                // .frame(width: 100, height: 100)
                                                    .cornerRadius(20)
                                            } placeholder: {
                                                ProgressView()
                                                    .scaledToFit()
                                                    .frame(width: 150, height: 150)
                                                    .cornerRadius(20)
                                            }
                                        }
                                        else
                                        {
                                            
                                        }
                                    }
                                }).padding()
                            }
                            Button(action: {
                                title = "Pics Name"
                                countValue = (countValue ?? 0) + 1
                            }, label: {
                                
                                Text("Click")
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    
                                    
                            })
                        }
        }
    
