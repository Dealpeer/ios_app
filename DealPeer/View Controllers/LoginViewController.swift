//
//  LoginViewController.swift
//  DealPeer
//
//  Created by Artem Katlenok on 24/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLoginButton.sizeToFit()
        googleLoginButton.sizeToFit()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func cancelLoginButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginViewController: GIDSignInUIDelegate {
    
    
    
}
