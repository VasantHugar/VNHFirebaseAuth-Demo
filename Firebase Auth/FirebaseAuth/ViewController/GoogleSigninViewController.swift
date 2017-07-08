//
//  GoogleSigninViewController.swift
//  Firebase Auth
//
//  Created by Vasant Hugar on 07/07/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn

class GoogleSigninViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let signinModel = FirebaseAuthGoogleSigninModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signInButton.style = .wide
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinButtonAction(_ sender: Any) {
        activityIndicator.startAnimating()
        signinModel.signIn()
    }
    
    @IBAction func signoutButtonAction(_ sender: Any) {
        signinModel.signOut()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension GoogleSigninViewController: GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
}
