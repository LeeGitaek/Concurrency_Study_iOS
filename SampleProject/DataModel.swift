//
//  DataModel.swift
//  SampleProject
//
//  Created by gitaeklee on 4/8/23.
//

import Foundation
import Combine

public struct DataModel: Decodable {
    var count: Int = 0
    var entries: [Entries] = []
}

public struct Entries: Decodable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case api = "API"
        case description = "Description"
        case auth = "Auth"
        case https = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
    
    var api: String
    var description: String
    var auth: String
    var https: Bool
    var cors: String
    var link: String
    var category: String
}

public struct ErrorModel {
    var errorMsg: String = ""
}
