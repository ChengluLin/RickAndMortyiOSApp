//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/1/11.
//

import Foundation


/// Represents unique API endpoint
@frozen enum RMEndpoint: String,  CaseIterable, Hashable {
    case character
    case location
    case episode
}

