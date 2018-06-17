//
//  ListViewController.swift
//  DealPeer
//
//  Created by Artem Katlenok on 17/06/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var listContainerView: UIView!
    @IBOutlet weak var mapContainerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var toggleMapButton: UIButton!
    
    private var isMapShown = false
    
    private(set) var listController: OfferListCollectionViewController? {
        didSet {
            print("did set list in \(type(of: self))")
        }
    }
    private(set) var mapController: MapViewController?{
        didSet {
            print("did set map in \(type(of: self))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapContainerViewHeightConstraint.constant = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleMapButtonTapped(_ sender: Any) {
        isMapShown.toggle()
        UIView.animate(withDuration: 0.5) {
            self.mapContainerViewHeightConstraint.constant = self.isMapShown ? 250 : 0
            self.view.layoutIfNeeded()
            self.listController?.changeScrollDirection(horizontal: self.isMapShown)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mapControllerEmbedSegue" {
            guard let viewController = segue.destination as? MapViewController else { return }
            mapController = viewController
        }
        
        if segue.identifier == "listControllerEmbedSegue" {
            guard let viewController = segue.destination as? OfferListCollectionViewController else { return }
            listController = viewController
        }
    }
    
}
