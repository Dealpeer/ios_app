//
//  Profile.swift
//  DealPeer
//
//  Created by Artem Katlenok on 19/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import Foundation

enum AuthMehod {
    case google, facebook
}

struct Profile {
    let authorizationMethod: AuthMehod
    let identifier: String
    let name: String
    let avatarURL: URL?
}
