//
//  CustomPropertyWrapperCamp.swift
//  podlearning
//
//  Created by Muhammad Ammar on 21/08/2024.
//

import SwiftUI

extension FileManager {
    
    static func documentPath(key : String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}

@propertyWrapper
struct FileManagerProperty : DynamicProperty {
  @State private var title : String
    let key: String
    
    var wrappedValue : String {
        get {
            title
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue : Binding<String> {
        
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }

    init(wrappedValue: String, _ key: String) {
        self.key = key
        do {
            title = try String(contentsOf: FileManager.documentPath(key: key),encoding: .utf8)
            
            print("Success")
            print("\(title)")
        }catch {
            title = wrappedValue
            print("Failed")
        }
    }
    
    func save(newValue: String) {
        do {
            try newValue.write(to: FileManager.documentPath(key: key), atomically: false, encoding: .utf8)
            print(NSHomeDirectory())
            title = newValue
            print("Success")
        } catch {
            print("Failed")
        }
    }
}

struct CustomPropertyWrapperCamp: View {
    
    @FileManagerProperty("custom_text1") private var title : String = "Starting Value"
    @FileManagerProperty("custom_text2") private var title2 : String = "Starting Value"
   //  var fileManagerProperty = FileManagerProperty()
  //  @State private var title: String = "Title Info"
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
            Text(title2)
                .font(.largeTitle)
            ChildPropertyView(title: $title)
            Button("Click 1") {
                title = "Click 1"
               // fileManagerProperty.save(newValue: "Click 1")
                //setTitle(newValue: "Click1")
            }
            
            Button("Click 2") {
                title2 = "Click 2"
                //fileManagerProperty.save(newValue: "Click 2")
                //setTitle(newValue: "Click2")
            }
            
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

struct ChildPropertyView : View {
    @Binding var title: String
    var body: some View {
        Button(title) {
            title = "Clicked"
        }
    }
}

#Preview {
    CustomPropertyWrapperCamp()
}
