//
//  RMCharacterInfoCollectionViewCellViewMode.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/6.
//

import Foundation
final class RMCharacterInfoCollectionViewCellViewModel {
    public let value: String
    public let title: String
    init(
        value: String,
        title: String
    ) {
        self.value = value
        self.title = title
    }
}
