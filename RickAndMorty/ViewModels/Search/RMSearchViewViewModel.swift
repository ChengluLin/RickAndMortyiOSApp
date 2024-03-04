//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/3/4.
//

import Foundation

// Responsibilities
// - show search results
// - show no results view
// - kick off API requests

final class RMSearchViewViewModel {
    
    let config: RMSearchViewController.Config
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
}
