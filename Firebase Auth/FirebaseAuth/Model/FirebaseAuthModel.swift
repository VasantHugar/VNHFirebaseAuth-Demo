//
//  FirebaseAuthModel.swift
//  Firebase Auth
//
//  Created by Vasant Hugar on 06/07/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit
import Firebase

class FirebaseAuthModel: NSObject {
    
    /// Call This from AppDelegate
    /// Then, in the application:didFinishLaunchingWithOptions: method, initialize the FirebaseApp object:
    static var configure: Void {
        FirebaseAuthConfigure.configure()
    }
    
    private var handler: AuthStateDidChangeListenerHandle?
    private static var obj: FirebaseAuthModel?
    
    /// Get Instance of Model whenever required from ViewController
    static var shared: FirebaseAuthModel {
        if obj == nil {
            obj = FirebaseAuthModel()
        }
        return obj!
    }
    
    /// For each of your app's views that need information about the signed-in user, attach a listener to the FIRAuth object.
    /// This listener gets called whenever the user's sign-in state changes.
    /// Attach the listener in the view controller's viewWillAppear method:
    func addChangeListener() {
        
        handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                
                let uid = user.uid
                let name: String = user.displayName ?? ""
                let email: String = user.email ?? ""
                let photoURL = user.photoURL
                
                print("\n**********************************************************")
                print("User uid: \(uid)")
                print("User name: \(name)")
                print("User email: \(email)")
                print("User photoURL: \(photoURL?.description)")
                print("**********************************************************\n")
            }
        }
    }
    
    /// And detach the listener in the view controller's viewWillDisappear method:
    func removeChangeListener() {
        
        if (handler != nil) {
            Auth.auth().removeStateDidChangeListener(handler!)
        }
    }
    
    /// Create a form that allows new users to register with your app using their email address and a password. When a user completes the form, validate the email address and password provided by the user, then pass them to the createUser method:
    ///
    /// - Parameters:
    ///   - email: Email Address
    ///   - password: Password
    func createUser(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            // ...
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
            else if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                
                let uid = user.uid
                let name: String = user.displayName ?? ""
                let email: String = user.email ?? ""
                let photoURL = user.photoURL
                
                print("\n**********************************************************")
                print("User uid: \(uid)")
                print("User name: \(name)")
                print("User email: \(email)")
                print("User photoURL: \(photoURL?.description)")
                print("**********************************************************\n")
            }
        }
    }
    
    /// Create a form that allows existing users to sign in using their email address and password. When a user completes the form, call the signIn method:
    ///
    /// - Parameters:
    ///   - email: Email Address
    ///   - password: Password
    func signin(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            // ...
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
            else if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                
                let uid = user.uid
                let name: String = user.displayName ?? ""
                let email: String = user.email ?? ""
                let photoURL = user.photoURL
                
                print("\n**********************************************************")
                print("User uid: \(uid)")
                print("User name: \(name)")
                print("User email: \(email)")
                print("User photoURL: \(photoURL?.description)")
                print("**********************************************************\n")
            }
        }
    }
    
    /// You can update a user's basic profile information—the user's display name and profile photo URL—with the FIRUserProfileChangeRequest class.
    ///
    /// - Parameters:
    ///   - displayName: Display Name
    ///   - photoURL: Photo URL
    func profileChange(displayName: String, photoURL: String) {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        changeRequest?.displayName = displayName
        changeRequest?.photoURL = URL(string: photoURL)
        
        changeRequest?.commitChanges { (error) in
            // ...
            print("\n**********************************************************")
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
            else {
                print("Profile Change Request -> Committed Successfully.")
            }
            print("**********************************************************\n")
        }
    }
    
    /// You can set a user's email address with the updateEmail:completion: method
    ///
    /// - Parameter email: Email to be replaced
    func updateEmail(email: String) {
        Auth.auth().currentUser?.updateEmail(to: email) { (error) in
            // ...
            print("\n**********************************************************")
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
            else {
                print("Email Updated Successfully.")
            }
            print("**********************************************************\n")
        }
    }
    
    /// You can send an address verification email to a user with the sendEmailVerificationWithCompletion: method
    func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            // ...
            print("\n**********************************************************")
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
            else {
                print("Sent Email Verification Successfully.")
            }
            print("**********************************************************\n")
        }
    }
    
    /// You can set a user's password with the updatePassword:completion: method
    ///
    /// - Parameter password: New Password
    func updatePassword(password: String) {
        
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            // ...
            print("\n**********************************************************")
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
            else {
                print("Password updated Successfully.")
            }
            print("**********************************************************\n")
        }
    }
    
    /// You can send a password reset email to a user with the sendPasswordResetWithEmail:completion: method
    ///
    /// - Parameter email: Email Address to which you would send a mail
    func sendPasswordReset(email: String) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            // ...
            print("\n**********************************************************")
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
            else {
                print("Sent password reset Successfully.")
            }
            print("**********************************************************\n")
        }
    }
    
    /// You can delete a user account with the deleteWithCompletion method.
    func delete() {
        
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            print("\n**********************************************************")
            if error != nil {
                print("Error Deleting account: \(error?.localizedDescription)")
            }
            else {
                print("Account Deleted Successfully.")
            }
            print("**********************************************************\n")
        }
    }
    
    //    func reAuthenticateUser() {
    //
    //        let user = Auth.auth().currentUser
    //        let credential: FIRAuthCredential?
    //
    //        // Prompt the user to re-provide their sign-in credentials
    //        user?.reauthenticate(with: credential!) { error in
    //            if let error = error {
    //                // An error happened.
    //            } else {
    //                // User re-authenticated.
    //            }
    //        }
    //    }
}

class FirebaseAuthConfigure: NSObject {
    
    //    Get Started with Firebase Authentication on iOS
    //
    //    You can use Firebase Authentication to allow users to sign in to your app using one or more sign-in methods, including email address and password sign-in,
    //    and federated identity providers such as Google Sign-in and Facebook Login.
    //    This tutorial gets you started with Firebase Authentication by showing you how to add email address and password sign-in to your app.
    
    //    Connect your app to Firebase
    //
    //    Install the Firebase SDK.
    //    In the Firebase console, add your app to your Firebase project.
    //    Add Firebase Authentication to your Xcode project
    //
    //    First, ensure the following dependency is in your project's Podfile:
    //
    //    pod 'Firebase/Auth'
    //    Then, run pod install and open the created .xcworkspace file.
    //
    //    Initialize the Firebase SDK
    //
    //    In your app delegate, first import the Firebase SDK:
    
    /// Then, in the application:didFinishLaunchingWithOptions: method, initialize the FirebaseApp object:
    class func configure() {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
    }
}
