//
//  MainViewController.swift
//  DealPeer
//
//  Created by Artem Katlenok on 17/06/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    let offerManager = OfferManager()
    
    private var listViewController: ListViewController? {
        didSet {
            print("did set list view controller")
        }
    }
    private var messagesViewController: MessagesViewController? {
        didSet {
            print("did set messages view controller")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func assignProperties() {
        viewControllers?.forEach {
            switch $0 {
            case is ListViewController:
                listViewController = $0 as? ListViewController
                if let list = listViewController?.listController {
                    print("added list as delegate")
                    offerManager.add(delegate: list)
                }
                if let map = listViewController?.mapController {
                    print("added map as delegate")
                    offerManager.add(delegate: map)
                }
            case is MessagesViewController:
                messagesViewController = $0 as? MessagesViewController
            default:
                print("unexpected view controller")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assignProperties()
        offerManager.performInitialEmptySearch()
    }
}
