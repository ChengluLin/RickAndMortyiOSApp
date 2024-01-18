//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/1/11.
//

import UIKit

/// Controllerto show and search for Characters
final class RMCharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Character"
        
        RMService.shared.execute(.listCharactersRequests, expection: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: "+String(model.info.count))
                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
