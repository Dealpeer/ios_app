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
    case failed(String)
    case success
}

struct Server {
    
    static func provideAllOffers(completionHandler: @escaping (RequestResult)->()) {
        let endpoint = DealPeerEndpoint.offers
        Alamofire.request(endpoint.endpointURL(),
                          method: endpoint.httpMethod(),
                          parameters: endpoint.parameters(),
                          encoding: JSONEncoding.default,
                          headers: endpoint.headers()).response { (response) in
                            print(response)
                            guard let jsonData = response.data else { return }
                            do {
                                let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
                                print(json)
                                
                                // serialize this 
                                
                            } catch let error {
                                print("error: \(error)")
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
    
    func endpointURL() -> String {
        switch self {
        case .authorize:
            return API.baseURL + ""
        case .offers:
            return API.baseURL + API.version + "/offers/search"
        }
    }
    
    func httpMethod() -> HTTPMethod {
        return HTTPMethod.post
    }
    
    func encoding() -> JSONEncoding {
        return .default
    }
    
    func headers() -> HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    func parameters() -> Parameters {
        return [String: Any]()
    }
}
