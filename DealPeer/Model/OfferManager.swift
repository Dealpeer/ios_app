//
//  OfferManager.swift
//  DealPeer
//
//  Created by Artem Katlenok on 06/06/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import Foundation

enum OfferUpdateResult {
    case storeUpdateSuccess([Offer])
    case storeUpdateFailed(Error)
}

typealias OfferUpdateResultClosure = (OfferUpdateResult) -> Void

protocol OffersUpdatable: class {
    func storeUpdatedOffers(offers: [Offer])
    func storeFailedToUpdateOffers(error: Error)
}

class OfferManager {
    private var storeUpdateClosures: [OfferUpdateResultClosure] = []
    var offers: [Offer] = []
    func appendUpdateClosure(closure: @escaping OfferUpdateResultClosure) {
        storeUpdateClosures.append(closure)
    }

    func provideOffers() {
        Server.provideAllOffers { (result) in
            switch result {
            case .failed(let updateError):
                self.storeUpdateClosures.forEach { $0(OfferUpdateResult.storeUpdateFailed(updateError)) }
            case .offersFetched(let updatedOffers):
                self.storeUpdateClosures.forEach { $0(OfferUpdateResult.storeUpdateSuccess(updatedOffers)) }
            }
        }
    }
}
