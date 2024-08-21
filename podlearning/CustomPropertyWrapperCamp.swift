//
//  CustomPropertyWrapperCamp.swift
//  podlearning
//
//  Created by Muhammad Ammar on 21/08/2024.
//

import SwiftUI

struct FileManagerProperty {
    var title : String = "Title"
    
    private var path : URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "custom_title.txt")
    }
    
    mutating func load() {
        do {
            title = try String(contentsOf: path,encoding: .utf8)
        }catch {
            
        }
    }
    
    
    
   mutating func save(newValue: String) {
        do {
            try newValue.write(to: path, atomically: false, encoding: .utf8)
            title = newValue
            print("Success")
        } catch {
            print("Failed")
        }
    }
}

struct CustomPropertyWrapperCamp: View {
    
    @State var fileManagerProperty = FileManagerProperty()
  //  @State private var title: String = "Title Info"
    var body: some View {
        VStack {
            Text(fileManagerProperty.title)
                .font(.largeTitle)
            
            Button("Click 1") {
                fileManagerProperty.save(newValue: "Click 1")
                //setTitle(newValue: "Click1")
            }
            
            Button("Click 2") {
                fileManagerProperty.save(newValue: "Click 2")
                //setTitle(newValue: "Click2")
            }
            
        }
        .onAppear {
            fileManagerProperty.load()
        }
    }
    
//    func setTitle(newValue: String) {
//        title = newValue.uppercased()
//        save(newValue: newValue.uppercased())
//    }
//    
//    private var path : URL {
//        FileManager.default
//            .urls(for: .documentDirectory, in: .userDomainMask)
//            .first!
//            .appending(path: "custom_title.txt")
//    }
//    
//    func save(newValue: String) {
//        do {
//            try newValue.write(to: path, atomically: false, encoding: .utf8)
//            print(NSHomeDirectory())
//            print("Success")
//        } catch {
//            print("Failed")
//        }
//    }
}

#Preview {
    CustomPropertyWrapperCamp()
}
