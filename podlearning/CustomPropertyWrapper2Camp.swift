//
//  CustomPropertyWrapper2Camp.swift
//  podlearning
//
//  Created by mac on 22/08/2024.
//

import SwiftUI

@propertyWrapper
struct Capitalized : DynamicProperty {
    
    
    @State private var value: String
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
    
    var wrappedValue: String {
        get {
            value
        }
        nonmutating set {
            value = newValue.capitalized
        }
    }
}

struct UserProfile :Codable {
    var name : String
    var age : Int
    var premium: Bool
}

@propertyWrapper
struct FileManagerCustomProperty<T: Codable> : DynamicProperty {
  @State private var value : T?
    let key: String
    
    var wrappedValue : T? {
        get {
            value
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue : Binding<T?> {
        
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }

    init(wrappedValue: T?, _ key: String) {
        self.key = key
        do {
            let url = FileManager.documentPath(key: key)
            let data = try Data(contentsOf: url)
            
            let object = try JSONDecoder().decode(T.self, from: data)
            value = object
            print("Success")
           // print("\(title)")
        }catch {
            value = wrappedValue
            print("Failed")
        }
    }
    
    func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentPath(key: key))
            value = newValue
            print("Success")
        } catch {
            print("Failed")
        }
    }
}

struct CustomPropertyWrapper2Camp: View {
    @FileManagerCustomProperty ("user_profile") private var user: UserProfile? = nil
    
    @Capitalized var title: String = "hello world!"
    var body: some View {
        VStack {
            Button(user?.name ?? "no value") {
                user = UserProfile(name: "Ammar", age: 29, premium: true)
            }
        }
        
    }
}

#Preview {
    CustomPropertyWrapper2Camp()
}
