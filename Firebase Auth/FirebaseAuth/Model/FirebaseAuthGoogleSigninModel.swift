//
//  FirebaseAuthGoogleSigninModel.swift
//  Firebase Auth
//
//  Created by Vasant Hugar on 07/07/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn

class FirebaseAuthGoogleSigninModel: NSObject {
    
    /// Call This from AppDelegate
    /// Then, in the application:didFinishLaunchingWithOptions: method, initialize the FirebaseApp object:
    static var configure: Void {
        FirebaseAuthConfigure.configure()
    }
    
    private static var obj: FirebaseAuthGoogleSigninModel?
    
    /// Get Instance of Model whenever required from ViewController
    static var shared: FirebaseAuthGoogleSigninModel {
        if obj == nil {
            obj = FirebaseAuthGoogleSigninModel()
        }
        return obj!
    }
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
    }
    
    /// SignIn Method
    func signIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    /// SignOut Method
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
    }
    
    /// Disconnect Method
    func disconnect() {
        GIDSignIn.sharedInstance().disconnect()
    }
}

extension FirebaseAuthGoogleSigninModel: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            print("SignIn Error : \(error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        let name = user.profile.name
        let email = user.profile.email
        
        print("\n**********************************************************")
        print("User name: \(name!)")
        print("User email: \(email!)")
        print("Credential provider: \(credential.provider)")
        print("**********************************************************\n")
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("SignIn Error : \(error.localizedDescription)")
    }
}
