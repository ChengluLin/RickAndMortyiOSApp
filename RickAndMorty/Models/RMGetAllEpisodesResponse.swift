//
//  RMGetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/20.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}
