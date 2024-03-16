//
//  RMSearchResultsView.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/3/15.
//

import UIKit

protocol RMSearchResultsViewDelegate: AnyObject {
    func reSearchResultsView(_ resultsView: RMSearchResultsView, didTapLocationAt location: Int)
}

/// Shows search results UI (Table or Collection an need)
class RMSearchResultsView: UIView {
    
    weak var delegate: RMSearchResultsViewDelegate?
    
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
    
    private var locationCellViewModels: [RMLocationTableViewCellViewModel] = []
    
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
        case .locations(let viewModels):
            setUpTableView(viewModels: viewModels)
        case .episodes(let viewModels):
            setUpcollectionView()
        }
    }
    
    private func setUpcollectionView() {
        
    }
    
    private func setUpTableView(viewModels: [RMLocationTableViewCellViewModel]) {
        tabelView.isHidden = false
        tabelView.delegate = self
        tabelView.dataSource = self
        self.locationCellViewModels = viewModels
        tabelView.reloadData()
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

//MARK: - TableViewDelegate

extension RMSearchResultsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.cellIdentifier, for: indexPath) as? RMLocationTableViewCell else {
            fatalError("Failed to dequeu RMLocationTableViewCell")
        }
        cell.configure(with: locationCellViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = locationCellViewModels[indexPath.row]
        self.delegate?.reSearchResultsView(self, didTapLocationAt: indexPath.row)
    }
}
