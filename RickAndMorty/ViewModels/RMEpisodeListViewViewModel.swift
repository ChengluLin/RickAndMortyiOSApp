//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by ChengLu on 2024/2/20.
//

import Foundation

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didSelectEpisode(_ character: RMEpisode)
    func didLoadMoreEpisodes(with newIndexPath: [IndexPath])
}

/// View Model to handie Episode list view logic
final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes {
//                let viewModel = RMEpisodeCollectionViewCellViewModel(
//                    characterName: character.name,
//                    characterStatus: character.status,
//                    characterImageUrl: URL(string: character.image)
//                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    /// Fetch initial set of characters (20)
    public func fetchCharacters() {
        RMService.shared.execute(
            .listCharactersRequests,
            expecting: RMGetAllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        print("Fatching more data", url)
        isLoadingMoreCharacters = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }

        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info

                if strongSelf.apiInfo?.next == info.next {
                    strongSelf.isLoadingMoreCharacters = false
                    return
                } else {
                    strongSelf.apiInfo = info
                }
                            
                let originalCount = strongSelf.characters.count
                let newConunt = moreResults.count
                let total = originalCount + newConunt
                let startingIndex = total - newConunt
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newConunt)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.characters.append(contentsOf: moreResults)

                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsToAdd )
                }
                strongSelf.isLoadingMoreCharacters = false
                
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

//MARK: - CollectionView

extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        <#code#>
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeCollectionViewCell.cellIdentifier, for: indexPath
        ) as? RMEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identfier,
                for: indexPath
              ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported footer")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(
            width: collectionView.frame.width,
            height: 100
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacer(character)
    }
    
}

//MARK: -  ScrolView
extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totaScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= ( totalContentHeight - totaScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCharacters(url: url)
            }
            timer.invalidate()
        }
        
        //        let xxxx = totalContentHeight - totaScrollViewFixedHeight
        
        //        print("Offset:", offset)
        //        print("xxx", xxxx)
        //        print("totalContentHeight:", totalContentHeight)
        //        print("totaScrollViewFixedHeight:", totaScrollViewFixedHeight)
        
    }
}
