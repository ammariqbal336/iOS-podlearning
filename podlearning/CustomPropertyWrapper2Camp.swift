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

struct FileManagerValue {
    static let shared = FileManagerValue()
    private init() {}
    
    let userProfile = FileManagerKeypath(key: "user_profile", type: UserProfile.self)
}

struct FileManagerKeypath<T: Codable> {
    let key: String
    let type: T.Type
    
}

struct CustomProjectedValue<T:Codable> {
    
    let binding : Binding<T?>
    let publisher : CurrentValueSubject<T? ,Never>
    
    var stream : AsyncPublisher<CurrentValueSubject<T?, Never>> {
       publisher.values
    }
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

    init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentPath(key: key)
            let data = try Data(contentsOf: url)
            
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            print("Success")
           // print("\(title)")
        }catch {
            _value = State(wrappedValue: nil)
            print("Failed")
        }
    }
    
    init(_ key: KeyPath<FileManagerValue, FileManagerKeypath<T>>) {
        let keyPath = FileManagerValue.shared[keyPath: key]
        let key = keyPath.key
        
        self.key = key
        do {
            let url = FileManager.documentPath(key: key)
            let data = try Data(contentsOf: url)
            
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            print("Success")
           // print("\(title)")
        }catch {
            _value = State(wrappedValue: wrappedValue)
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
  //  @FileManagerCustomProperty ("user_profile") private var user: UserProfile?
   // @FileManagerCustomProperty (\.userProfile) private var user
    @FileManagerCustomStreamProperty (\.userProfile) private var user
    
    @Capitalized var title: String = "hello world!"
    var body: some View {
        VStack {
            Button(user?.name ?? "no value") {
                user = UserProfile(name: "Merger", age: 29, premium: true)
            }
            ChildCustomProperty(user: $user.binding)
        }
        .onReceive($user.publisher, perform: { newValue in
            print("New Value Stream \(newValue)")
        })
        .task {
            for await newValue in $user.stream {
                print("New Value Stream \(newValue)")
            }
        }
        
    }
}

struct ChildCustomProperty : View {
    @Binding var user : UserProfile?
    var body: some View {
        Button(user?.name ?? "no value") {
            user = UserProfile(name: "Final", age: 29, premium: true)
        }
    }
}

#Preview {
    CustomPropertyWrapper2Camp()
}

import Combine

@propertyWrapper
struct FileManagerCustomStreamProperty<T: Codable> : DynamicProperty {
  @State private var value : T?
    let key: String
    private let publisher: CurrentValueSubject<T?, Never>
    
    var wrappedValue : T? {
        get {
            value
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    var projectedValue: CustomProjectedValue<T> {
        CustomProjectedValue(
            binding: Binding {
                         wrappedValue
                    } set: { newValue in
                        wrappedValue = newValue
                    }
             , publisher: publisher)
    }
//    var projectedValue : Binding<T?> {
//        
//        Binding {
//            wrappedValue
//        } set: { newValue in
//            wrappedValue = newValue
//        }
//
//    }
//    var projectedValue : CurrentValueSubject<T?,Never> {
//        publisher
//    }

    init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentPath(key: key)
            let data = try Data(contentsOf: url)
            
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            print("Success")
           // print("\(title)")
        }catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print("Failed")
        }
    }
    
    init(_ key: KeyPath<FileManagerValue, FileManagerKeypath<T>>) {
        let keyPath = FileManagerValue.shared[keyPath: key]
        let key = keyPath.key
        
        self.key = key
        do {
            let url = FileManager.documentPath(key: key)
            let data = try Data(contentsOf: url)
            
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            print("Success")
           // print("\(title)")
        }catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print("Failed")
        }
    }
    
    func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentPath(key: key))
            value = newValue
            publisher.send(newValue)
            print("Success")
        } catch {
            print("Failed")
        }
    }
}
