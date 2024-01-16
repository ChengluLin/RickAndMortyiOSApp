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
        
        let request = RMRequest(
            endpoint: .character,
            queryParameters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "staus", value: "alive"),
                
            ]
        )
        
        print(request.url)
        
//        RMService.shared.execute(request,
//                                 expection: RMCharacter.self) { result in
//            switch result {
//            case .success(<#T##RMCharacter#>)
//            case .failure(<#T##Failure#>)
//            }
//        }


        
    }
}
