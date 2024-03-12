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
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    private var searchText = ""
    
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var searchResultHandler: (() -> Void)?
    
    //MARK: - Init
    
    init(config: RMSearchViewController.Config) {
        self.config = config
        
    }
    
    //MARK: - Public
    
    public func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    public func executeSearch() {
        // Test search text
        searchText = "Rick"
        
        //Build arguments
        var queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText)
        ]

        // Add options
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key:  RMSearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        // Cearte request
        let request = RMRequest(
            endpoint: config.type.endpoint,
            queryParameters: queryParams
        )
        
        print(request.url?.absoluteString)
        
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Search results found:", model.results.count)
            case .failure(let error):
                break
            }
        }
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func registerOptionChangeBlock(
        _ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void
    ) {
        self.optionMapUpdateBlock = block
    }
}
