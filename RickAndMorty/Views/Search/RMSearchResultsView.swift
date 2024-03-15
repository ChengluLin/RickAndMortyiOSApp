//
//  RMSearchResultsView.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/3/15.
//

import UIKit


/// Shows search results UI (Table or Collection an need)
class RMSearchResultsView: UIView {
    
    private var viewModel: RMSearchResultViewModel? {
        didSet {
            self.processViewModel()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func processViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        switch viewModel {
        case .characters(let viewModels):
            break
        case .episodes(let viewModels):
            break
        case .locations(let viewModels):
            break
        }
    }
    
    private func addConstraints() {
        
    }
    
    public func configure(with viewModel: RMSearchResultViewModel) {
        self.viewModel = viewModel
    }

}
