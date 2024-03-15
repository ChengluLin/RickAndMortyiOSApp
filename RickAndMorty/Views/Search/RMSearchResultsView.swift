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
    
    private let tabelView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RMLocationTableViewCell.self,
                           forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        tableView.isHidden = true
//        tableView.backgroundColor = .yellow
        return tableView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(tabelView)
        
        addConstraints()
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
            setUpcollectionView()
        case .episodes(let viewModels):
            setUpcollectionView()
        case .locations(let viewModels):
            setUpTableView()
        }
    }
    
    private func setUpcollectionView() {
        
    }
    
    private func setUpTableView() {
        tabelView.isHidden = false
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tabelView.topAnchor.constraint(equalTo: topAnchor),
            tabelView.leftAnchor.constraint(equalTo: leftAnchor),
            tabelView.rightAnchor.constraint(equalTo: rightAnchor),
            tabelView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
    
    public func configure(with viewModel: RMSearchResultViewModel) {
        self.viewModel = viewModel
    }
    
}
