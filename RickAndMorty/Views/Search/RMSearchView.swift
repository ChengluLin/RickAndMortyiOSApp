//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/3/4.
//

import UIKit

final class RMSearchView: UIView {

    let viewModel: RMSearchViewViewModel
    
    //MARK: - Subviews
    
    private let SearchInputView = RMSearchInputView()
    
    // No results view
    
    private let noResultsView = RMNoSearchResultsView()
    
    // Results collectionView 
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super .init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView, SearchInputView)
        addConstraints()
        
        SearchInputView.configure(with: RMSearchInputViewViewModel(type: viewModel.config.type))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // Search input view
            SearchInputView.topAnchor.constraint(equalTo: topAnchor),
            SearchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            SearchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            SearchInputView.heightAnchor.constraint(equalToConstant: 110),
            
            // No Results
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    

}

//MARK: - CollectionViewDelegate

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
