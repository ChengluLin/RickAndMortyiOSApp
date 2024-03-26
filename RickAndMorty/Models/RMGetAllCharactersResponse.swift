//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/1/18.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}


