//
//  MainTabBarViewController.swift
//  DealPeer
//
//  Created by Artem Katlenok on 06/06/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let offerManager = OfferManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.forEach { controller in
            if let viewController = controller as? OffersUpdatable {
                offerManager.appendUpdateClosure { result in
                    switch result {
                    case .storeUpdateSuccess(let offers):
                        viewController.storeUpdatedOffers(offers: offers)
                    case .storeUpdateFailed(let error):
                        viewController.storeFailedToUpdateOffers(error: error)
                    }
                }
            }

            if let viewController = controller as? LoginViewController {
                viewController.title = "Login"
            }

        }
        offerManager.provideOffers()
    }
}
