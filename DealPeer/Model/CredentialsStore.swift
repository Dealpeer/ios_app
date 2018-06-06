//
//  CredentialsStore.swift
//  DealPeer
//
//  Created by Artem Katlenok on 27/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import Foundation

class CredentialsStore {

    // Singleton for now
    static let store = CredentialsStore()
    private init() {}

    private var user: Profile? {
        didSet {
            print("Registered as: \(String(describing: user?.name)) with \(String(describing: user?.authorizationMethod))")
        }
    }

    func setUserProfile(_ profile: Profile) {
       user = profile
    }

    func userProfile() -> Profile? {
        return user
    }

    func isCurrentlySignedIn() -> Bool {
        return user != nil
    }
}
