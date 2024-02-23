//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/22.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable, Hashable {
    let id = UUID()
    
    private var type: RMSettingsOption
    
    //MARK: -  Init
    init(type: RMSettingsOption) {
        self.type = type
    }
    
    //MARK: - Public
    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}
