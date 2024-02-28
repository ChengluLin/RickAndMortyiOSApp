//
//  LocationViewViewModel.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/29.
//

import Foundation

final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = []
    
    // Location response info
    // Will contain next url, if present
    
    init() {
    }
    
    public func fetchLocations() {
        RMService.shared.execute(.listCharactersRequests, expecting: String.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
