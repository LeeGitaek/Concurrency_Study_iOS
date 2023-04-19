//
//  NetworkProvider.swift
//  SampleProject
//
//  Created by gitaeklee on 4/8/23.
//

import Foundation
import Combine

public class NetworkProvider {

    var baseURL: String = "url"

    init() { }
    
    func fetch() async throws -> AnyPublisher<DataModel, Error> {
        let requestURL: URL = URL.init(string: baseURL)!
        return URLSession.shared.dataTaskPublisher(for: requestURL)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<400).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return try JSONDecoder().decode(DataModel.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
