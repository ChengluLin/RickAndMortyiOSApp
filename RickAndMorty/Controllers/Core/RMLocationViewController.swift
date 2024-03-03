//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/1/11.
//

import UIKit

/// Controllerto show and search for Location
final class RMLocationViewController: UIViewController, RMLocationViewViewModelDelegate, RMLocationViewDelegate {
    
    private let primaryView = RMLocationView()
    
    private let viewModel = RMLocationViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        title = "Location"
        addSearchButton()
        addConstraints()
        viewModel.delegate = self
        viewModel.fetchLocations()
        primaryView.delegate = self
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    @objc
    private func didTapSearch() {
        
    }
    
    //MARK: - RMLocationViewDelegate
    
    func rmLocationView(_ locationView: RMLocationView, didSelect loaction: RMLocation) {
        let vc = RMLocationDetailViewController(location: loaction)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - LocationViewModel Delegate
    
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
    
}
