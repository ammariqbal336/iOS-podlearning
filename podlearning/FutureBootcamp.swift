//
//  FutureBootcamp.swift
//  podlearning
//
//  Created by mac on 15/08/2024.
//

import SwiftUI
import Combine

class FutureBootcampViewModel : ObservableObject {
    @Published var futureValue = ""
    var cancellable = Set<AnyCancellable>()
    
    var url = URL(string: "https://www.google.com")
    init(){
        getValues()
    }
    
    func getValues(){
        getFutureClousure()
            .sink { _ in
                
            } receiveValue: { [weak self] returnValue in
                self?.futureValue = returnValue
            }
            .store(in: &cancellable)

//        getClousure { value, error in
//            self.futureValue = value
//        }
        
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError>{
        URLSession.shared.dataTaskPublisher(for: url!)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
                
            })
            .eraseToAnyPublisher()

    }
    
    func getClousure(completion: @escaping (_ value: String,_ error: URLError?) -> ()) {
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                completion("", nil)
            }
            else {
                completion("New Value Clousure", nil)
            }
        }
        .resume()
    }
    
    func getFutureClousure () -> Future<String, URLError> {
        
        Future { [weak self] clousure in
            self?.getClousure { value, error in
                if let error = error {
                    clousure(.failure(error))
                }
                else {
                    clousure(.success("New Value Future"))
                }
            }
        }
    }
}

struct FutureBootcamp: View {
    @StateObject private var vm = FutureBootcampViewModel()
    var body: some View {
        Text(vm.futureValue)
    }
}

#Preview {
    FutureBootcamp()
}
