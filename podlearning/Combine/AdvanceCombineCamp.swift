//
//  AdvanceCombineCamp.swift
//  podlearning
//
//  Created by mac on 12/08/2024.
//

import SwiftUI
import Combine

class AdvanceCombineService {
    
    @Published var publishedValue: String = "First Value"
    
    init() {
        getFakeData()
    }
    
    func getFakeData() {
        let array : [String] = ["one","two", "three"]
        for x in array.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double((x+1) * 1)) {
                self.publishedValue = array[x]
            }
        }
       
       
    }
}
class AdvanceCombineViewModel: ObservableObject {
    
    @Published var data: [String] = []
    var cancelable = Set<AnyCancellable>()
    let service : AdvanceCombineService = AdvanceCombineService()
    
    init() {
        getData()
    }
    
    func getData() {
        service.$publishedValue
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        break
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancelable)

    }
    
    
}

struct AdvanceCombineCamp: View {
    
    @StateObject var vm : AdvanceCombineViewModel = AdvanceCombineViewModel()
    var body: some View {
        VStack {
            ForEach(vm.data,id: \.self) { item in
                Text(item)
                    .font(.title)
                    .bold()
            }
        }
    }
}

#Preview {
    AdvanceCombineCamp()
}
