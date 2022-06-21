//
//  LoginViewController.swift
//  09SpotifyLoginSample
//
//  Created by 李 グッゴン on 2022/06/20.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self, callback: { [unowned self] user, error in
            if let error = error {
                print("ERROR Google Sign In \(error.localizedDescription)")
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential, completion: { _, _ in
                self.showMainViewController()
            })
        })
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.show(viewController, sender: nil)
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
    }
    
}
