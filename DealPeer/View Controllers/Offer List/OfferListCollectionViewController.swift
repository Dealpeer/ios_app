//
//  OfferListCollectionViewController.swift
//  DealPeer
//
//  Created by Artem Katlenok on 06/06/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit

private let reuseIdentifier = "offerCollectionViewCell"

class OfferListCollectionViewController: UICollectionViewController {

    var dataSource: [Offer] = []

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

        return cell
    }
}

extension OfferListCollectionViewController: OffersUpdatable {

    func storeUpdatedOffers(offers: [Offer]) {
        print("\(type(of: self)) recieved \(offers.count) offers")
        dataSource = offers
        collectionView?.reloadData()
    }

    func storeFailedToUpdateOffers(error: Error) {
        print("\(type(of: self)) recieved offer update error")
    }

}
