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
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: CallBack with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expection type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void) {

    }
}
