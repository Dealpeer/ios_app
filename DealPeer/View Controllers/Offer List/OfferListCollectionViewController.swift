//
//  OfferListCollectionViewController.swift
//  DealPeer
//
//  Created by Artem Katlenok on 06/06/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "offerCollectionViewCell"

class OfferListCollectionViewController: UICollectionViewController {

    var dataSource: [SearchResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? OfferCollectionViewCell else { return UICollectionViewCell() }

        let offer = dataSource[indexPath.row]
        cell.offerNameLabel.text = offer.name.first?.caption
        cell.offerImage.image = #imageLiteral(resourceName: "placeholder")
        
        if let imageUrlString = offer.images.first, let imageURL = URL(string: imageUrlString)  {
            cell.offerImage.sd_setImage(with: imageURL)
        }

        return cell
    }
}

extension OfferListCollectionViewController {
    
    func changeScrollDirection(horizontal: Bool) {
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = horizontal ? .horizontal : .vertical
        }
    }
}

extension OfferListCollectionViewController: OffersUpdatable {
    
    func storeRecievedAvailableOffers(result: [SearchResult]) {
        print("\(type(of: self)) recieved \(result.count) search results")
        dataSource = result
        collectionView?.reloadData()
    }
    
    func storeUpdatedOffers(offers: [Offer]) {
        print("\(type(of: self)) recieved \(offers.count) offers")
        
    }

    func storeFailedToUpdateOffers(error: Error) {
        print("\(type(of: self)) recieved offer update error: \(error.localizedDescription)")
    }

}
