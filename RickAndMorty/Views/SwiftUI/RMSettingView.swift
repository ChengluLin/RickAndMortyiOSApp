//
//  RMSettingView.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/22.
//

import SwiftUI

struct RMSettingView: View {
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color(viewModel.iconContainerColor))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                Text(viewModel.title)
                    .padding(.leading, 10)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

#Preview {
    RMSettingView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({return RMSettingsCellViewModel(type: $0)
    })))
}
