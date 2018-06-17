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
    case searchResultsFetched([SearchResult])
}

struct Server {
    
    struct RawOfferDataContainer: Codable {
        let result: [Offer]
    }
    
    struct RawSearchResultDataContainer: Codable {
        let result: [SearchResult]
    }
    
    static func provideAllOffers(completionHandler: @escaping (RequestResult) -> Void) {
        let endpoint = DealPeerEndpoint.offers
        print(endpoint.parameters)
        Alamofire.request(endpoint.endpointURL,
                          method: endpoint.httpMethod,
                          parameters: endpoint.parameters,
                          encoding: JSONEncoding.default,
                          headers: endpoint.headers).response { response in
                            
                            
                            guard let jsonData = response.data else { return }
                
                            do {
                                let offerContainer = try JSONDecoder().decode(RawSearchResultDataContainer.self, from: jsonData)
                                
                                completionHandler(.searchResultsFetched(offerContainer.result))
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
    case search(String)
    
    var endpointURL: String {
        switch self {
        case .authorize:
            return API.baseURL + ""
        case .offers, .search(_):
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
        return ["Content-Type": "application/json", "Accept": "application/json"]
    }
    
    var parameters: Parameters {
        switch self {
        case .authorize:
            return [String: Any]()
        case .offers:
            return SearchRequest.allOffers.parameters
        case .search(let searchString):
            return SearchRequest.text(searchString).parameters
        }
    }
}

enum SearchRequest {
    case allOffers
    case text(String)
    
    var parameters: [String: Any] {
        switch self {
        case .allOffers:
            return ["query_language": "russian"] // This one is obviously a hack, needs to be fixed
        case .text(let searchString):
            return ["query_language": "russian", "query": searchString]
        }
    }
}
