//
//  RMSearchResultViewModel.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/3/14.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
