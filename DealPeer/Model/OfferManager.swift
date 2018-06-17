//
//  OfferManager.swift
//  DealPeer
//
//  Created by Artem Katlenok on 06/06/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import Foundation

enum OfferUpdateResult {
    case storeUpdateSearchResults([SearchResult])
    case storeUpdateOffers([Offer])
    case storeUpdateFailed(Error)
}

typealias OfferUpdateResultClosure = (OfferUpdateResult) -> Void

protocol OffersUpdatable: class {
    func storeRecievedAvailableOffers(result: [SearchResult])
    func storeUpdatedOffers(offers: [Offer])
    func storeFailedToUpdateOffers(error: Error)
}

class OfferManager {
    
    private(set) var multicast = MulticastDelegate<OffersUpdatable>()
    
    var offers: [Offer] = []
    var searchResults: [SearchResult] = []
    
    func performInitialEmptySearch() {
        Server.provideAllOffers { (result) in
            switch result {
            case .failed(let updateError):
                self.multicast.broadcast { $0.storeFailedToUpdateOffers(error: updateError)
                }
            case .offersFetched(let updatedOffers):
                self.multicast.broadcast { $0.storeUpdatedOffers(offers: updatedOffers) }
                self.offers = updatedOffers
            case .searchResultsFetched(let searchResults):
                self.multicast.broadcast { $0.storeRecievedAvailableOffers(result: searchResults)}
                self.searchResults = searchResults
            }
        }
    }
}

extension OfferManager: MultiCastable { typealias MulticastType = OffersUpdatable }
