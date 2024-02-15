//
//  RMCharacterInfoCollectionViewCellViewMode.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/6.
//

import Foundation
import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    private let type: `Type`
    private let value: String
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None"}
       return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type` {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemPink
            case .location:
                return .systemYellow
            case .episodeCount:
                return .systemMint
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status:
                return "Someting"
            case .gender:
                return "Someting"
            case .type:
                return "Someting"
            case .species:
                return "Someting"
            case .origin:
                return "Someting"
            case .created:
                return "Someting"
            case .location:
                return "Someting"
            case .episodeCount:
                return "Someting"
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.value = value
        self.type = type
    }
}
