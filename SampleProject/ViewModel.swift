//
//  ViewModel.swift
//  SampleProject
//
//  Created by gitaeklee on 4/8/23.
//

import Foundation
import Combine

@MainActor
public final class ViewModel: ObservableObject {
    
    @Published var model: DataModel = DataModel()
    @Published var errorModel: ErrorModel = ErrorModel()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() { }
    
    func fetchProvider() async {
        let network = NetworkProvider()
        do {
            try await network.fetch()
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                        case .finished:
                            print("finished \(completion)")
                        case .failure(_):
                            print("failure")
                            self?.errorModel.errorMsg = "completion: failure"
                    }
                }, receiveValue: { [weak self] data in
                    self?.model = data
                })
                .store(in: &cancellable)
        } catch {
            errorModel.errorMsg = "error: fetch data"
        }
    }
}
