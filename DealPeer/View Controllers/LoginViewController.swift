//
//  LoginViewController.swift
//  DealPeer
//
//  Created by Artem Katlenok on 24/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn

class LoginViewController: UIViewController {
   
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.layer.cornerRadius = 10.0
        
        let facebookLoginButton = LoginButton(readPermissions: [.publicProfile, .email])
        facebookLoginButton.center = view.center
        view.addSubview(facebookLoginButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        googleLoginButton.sizeToFit()
    }
    
    @IBAction func cancelLoginButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginViewController: GIDSignInUIDelegate {
    
    
    
}

extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    

}
