//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/1/24.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    //MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    public func fatchCharacterData() {
        guard let url = requestUrl,
              let request = RMRequest(url: url) else {
            print("Failed to created")
            return
        }
    }
}
