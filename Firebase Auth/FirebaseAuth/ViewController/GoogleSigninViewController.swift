//
//  GoogleSigninViewController.swift
//  Firebase Auth
//
//  Created by 3Embed on 07/07/17.
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
//        GIDSignIn.sharedInstance().signIn()
        signinModel.signIn()
    }
    
    @IBAction func signoutButtonAction(_ sender: Any) {
//        GIDSignIn.sharedInstance().signOut()
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

//extension GoogleSigninViewController: GIDSignInDelegate {
//    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//        // ...
//        if let error = error {
//            // ...
//            print("SignIn Error : \(error.localizedDescription)")
//            activityIndicator.stopAnimating()
//            return
//        }
//        
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                       accessToken: authentication.accessToken)
//        // ...
//        
//        let name = user.profile.name
//        let email = user.profile.email
//        
//        print("\n**********************************************************")
//        print("User name: \(name!)")
//        print("User email: \(email!)")
//        print("Credential provider: \(credential.provider)")
//        print("**********************************************************\n")
//        
//        self.user.text = "Name: " + name! + "\n" + "Email: " + email!
//        
//        activityIndicator.stopAnimating()
//        
//    }
//    
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//        // Perform any operations when the user disconnects from app here.
//        // ...
//        print("SignIn Error : \(error.localizedDescription)")
//        
//        activityIndicator.stopAnimating()
//    }
//}
