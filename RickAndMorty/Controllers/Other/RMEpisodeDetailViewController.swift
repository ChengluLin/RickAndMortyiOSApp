//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/16.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {

    private let url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: -  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }

}
