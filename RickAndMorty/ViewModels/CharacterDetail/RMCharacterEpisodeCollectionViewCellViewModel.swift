//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/6.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    public let episodeDataUrl: URL?
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
}
