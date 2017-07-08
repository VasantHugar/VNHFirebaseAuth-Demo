//
//  FBLoginViewController.swift
//  Firebase Auth
//
//  Created by Vasant Hugar on 07/07/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit

class FBLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        /******************** OR ********************/
        //        let loginButton = FBSDKLoginButton()
        //        loginButton.delegate = self
        //
        //        loginButton.center = view.center
        //        view.addSubview(loginButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension FBLoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print("\n\nFB SignIn Error : \(error.localizedDescription)\n\n")
            return
        }
        // ...
        guard result.isCancelled == false else {
            return
        }
        
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                print("\n\nFB SignIn Error : \(error.localizedDescription)\n\n")
                return
            }
            // User is signed in
            // ...
            let uid = user?.uid
            let name = user?.displayName
            let email = user?.providerID
            
            print("\n**********************************************************")
            print("User id: \(uid!)")
            print("User name: \(name!)")
            print("User email: \(email!)")
            print("Credential provider: \(credential.provider)")
            print("**********************************************************\n")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
}
