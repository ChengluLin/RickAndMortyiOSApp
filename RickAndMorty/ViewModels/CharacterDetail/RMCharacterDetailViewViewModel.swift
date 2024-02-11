//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/1/24.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        
        case information(viewModel: [RMCharacterInfoCollectionViewCellViewModel])
        
        case episodes(viewModel: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    //MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        
        
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(viewModel: [
                .init(value: character.status.text, title: "Status"),
                .init(value: character.gender.rawValue, title: "Gender"),
                .init(value: character.type, title: "Type"),
                .init(value: character.species, title: "Species"),
                .init(value: character.origin.name, title: "Origin"),
                .init(value: character.location.name, title: "Location"),
                .init(value: character.created, title: "Created"),
                .init(value: "\(character.episode.count)", title: "Total Episodes"),
            ]),
            .episodes(viewModel: character.episode.compactMap ({
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
            }))
        ]
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
//MARK: - Layouts
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 10,
                                                     trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(150)),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

        return section
    }
    
    public func createEpisoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
