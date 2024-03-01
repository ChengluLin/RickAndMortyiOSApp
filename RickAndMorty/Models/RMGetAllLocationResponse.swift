//
//  RMGetLocationResponse.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/29.
//

import Foundation

struct RMGetAllLocationResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMLocation]
}
