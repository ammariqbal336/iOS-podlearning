//
//  CombineCamp.swift
//  podlearning
//
//  Created by mac on 10/08/2024.
//

import SwiftUI
import Combine


struct PostModel: Identifiable,Codable {
    let userId : Int
    let id: Int
    let title: String
    let body: String
}

class CombineViewModel : ObservableObject {
    @Published var posts : [PostModel] = []
    var cancelable = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTaskPublisher(for:url)
            .receive(on: DispatchQueue.main)
            .tryMap { (data,response) -> Data in
                guard let response = response as? HTTPURLResponse,
                     response.statusCode >=  200 && response.statusCode <= 300 else {
                         throw URLError(.badServerResponse)
                     }
                return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("Completion \(completion)")
            } receiveValue: { [weak self] (posts) in
                self?.posts = posts
            }
            .store(in: &cancelable)
    }
}

struct CombineCamp: View {
    
    @StateObject var vm = CombineViewModel()
    var body: some View {
        List {
            VStack(alignment: .leading) {
                ForEach(vm.posts,id: \.id) { post in
                    Text(post.title)
                        .foregroundColor(.blue)
                        .background(.green)
                    Text(post.body)
                    Spacer(minLength: 20)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
}

#Preview {
    CombineCamp()
}
