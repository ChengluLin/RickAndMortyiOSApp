//
//  RMService.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/1/11.
//

import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService {
    
    /// shared singleton instance
    static let shared = RMService()
    
    private init() {}
    
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
