//
//  Server.swift
//  DealPeer
//
//  Created by Artem Katlenok on 19/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import Foundation

struct Server {
    
    let authenticator: Authenticator
    let api: API
}

struct Authenticator {
    
}

struct API {
    
    private let baseURL = "https://api.dealpeer.com"
    
}

enum DealPeerEndpoint {
    
    case authorize
}
