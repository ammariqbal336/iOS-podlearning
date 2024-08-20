//
//  ErrorAlertCamp.swift
//  podlearning
//
//  Created by mac on 20/08/2024.
//

import SwiftUI


protocol AppAlert {
    var title: String { get }
    var subTitle: String? { get }
    var buttons: AnyView { get }
}

extension View {
    
    func showCustomAlert<T: AppAlert> (error: Binding<T?>) -> some View {
        self
            .alert(error.wrappedValue?.title ?? "Error", isPresented: Binding(value: error), actions: {
                
                error.wrappedValue?.buttons
                
            }, message: {
                if let subTitle = error.wrappedValue?.subTitle {
                    Text(subTitle)
                }
                
            })
    }
}

struct ErrorAlertCamp: View {
    @State private var error : MyCustomAlert? = nil
    
    var body: some View {
        Button("Click Me") {
            saveData()
        }
        .showCustomAlert(error: $error)
        
    }
    
    
   
    
    enum MyCustomAlert : Error ,LocalizedError, AppAlert {
    
        case noInternetConnection
        case dataNotFound
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "No Internet Connection"
            case .dataNotFound:
                return "No Data Found"
            }
        }
        
        var title : String {
            switch self {
            case .noInternetConnection:
                return "Internet Issue"
            case .dataNotFound:
                return "Data Error"
            }
        }
        
        var subTitle: String? {
            switch self {
            case .noInternetConnection:
                return "Check Internet Connection"
            case .dataNotFound:
                return "No Data Found"
            }
        }
        
        var buttons: AnyView {
            AnyView(getButtonAlert())
        }
        
        
        @ViewBuilder
        func getButtonAlert() -> some View {
            switch self {
            case .noInternetConnection:
                Button("OK") {
                    
                }
                Button("Retry") {
                    
                }
            case .dataNotFound:
                Button("Retry") {
                    
                }
            }
        }
    }
    
    func saveData() {
        let isSuccessful = false
        
        if(isSuccessful) {
            
        }else {
            //let _error : Error = MyCustomError.noInternetConnection
            
            error = .noInternetConnection
        }
    }
}



#Preview {
    ErrorAlertCamp()
}
