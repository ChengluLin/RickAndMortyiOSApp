//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/1/11.
//

import Foundation
struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
