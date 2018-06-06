//
//  Server.swift
//  DealPeer
//
//  Created by Artem Katlenok on 19/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import Foundation
import Alamofire

enum RequestResult {
    case failed(Error)
    case offersFetched([Offer])
}

struct Server {

    struct RawOfferDataContainer: Codable {
        let result: [Offer]
    }

    static func provideAllOffers(completionHandler: @escaping (RequestResult) -> Void) {

        let endpoint = DealPeerEndpoint.offers
        Alamofire.request(endpoint.endpointURL,
                          method: endpoint.httpMethod,
                          parameters: endpoint.parameters,
                          encoding: JSONEncoding.default,
                          headers: endpoint.headers).response { response in
                            guard let jsonData = response.data else { return }
                            do {
                                let offerContainer = try JSONDecoder().decode(RawOfferDataContainer.self, from: jsonData)
                                completionHandler(.offersFetched(offerContainer.result))
                            } catch let error {
                                completionHandler(.failed(error))
                            }
        }
    }
}

struct Authenticator {

}

struct API {
    static let baseURL = "https://api.dealpeer.com"
    static let version = "/v1"
}

public enum DealPeerEndpoint {

    case authorize
    case offers

    var endpointURL: String {
        switch self {
        case .authorize:
            return API.baseURL + ""
        case .offers:
            return API.baseURL + API.version + "/offers/search"
        }
    }

    var httpMethod: HTTPMethod {
        return HTTPMethod.post
    }

    var encoding: JSONEncoding {
        return .default
    }

    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }

    var parameters: Parameters {
        return [String: Any]()
    }
}
