//
//  TwitterLoginViewController.swift
//  Firebase Auth
//
//  Created by Vasant Hugar on 08/07/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit
import Firebase
import TwitterKit

class TwitterLoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: TWTRLogInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        Twitter.sharedInstance().start(withConsumerKey: "inMB6fJB9QaEhD4dXuHkzCZBX",
                                       consumerSecret: "qAf8uxBi4Bn1RULYevNjf6PdzSCTO4Py15fF2spkjqHuhOBZMv")
        
        loginButton.logInCompletion = { (session, error) in
            
            if (session != nil) {
                
                // User is signed in
                // ...
                let authToken = session?.authToken
                let authTokenSecret = session?.authTokenSecret
                
                print("\n\nAuthToken: \(authToken!)")
                print("AuthTokenSecret: \(authTokenSecret)\n\n")
                
                let credential = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        // ...
                        print("\n\nTwitter Login Error : \(error.localizedDescription)\n\n")
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
            else {
                // ...
                print("Twitter Login Error: \(error?.localizedDescription)")
            }
        }
        /********** OR ******************/
        
        //        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
        //            if (session != nil) {
        //
        //                // User is signed in
        //                // ...
        //                let authToken = session?.authToken
        //                let authTokenSecret = session?.authTokenSecret
        //
        //                print("\n\nAuthToken: \(authToken!)")
        //                print("AuthTokenSecret: \(authTokenSecret)\n\n")
        //
        //                let credential = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
        //                Auth.auth().signIn(with: credential) { (user, error) in
        //                    if let error = error {
        //                        // ...
        //                        print("\n\nTwitter Login Error : \(error.localizedDescription)\n\n")
        //                        return
        //                    }
        //                    // User is signed in
        //                    // ...
        //                    let uid = user?.uid
        //                    let name = user?.displayName
        //                    let email = user?.providerID
        //
        //                    print("\n**********************************************************")
        //                    print("User id: \(uid!)")
        //                    print("User name: \(name!)")
        //                    print("User email: \(email!)")
        //                    print("Credential provider: \(credential.provider)")
        //                    print("**********************************************************\n")
        //                }
        //            }
        //            else {
        //                // ...
        //                print("Twitter Login Error: \(error?.localizedDescription)")
        //            }
        //        })
        //
        //        logInButton.center = view.center
        //        view.addSubview(logInButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            
            if (session != nil) {
                // User is signed in
                // ...
                let authToken = session?.authToken
                let authTokenSecret = session?.authTokenSecret
                
                print("\n\nAuthToken: \(authToken!)")
                print("AuthTokenSecret: \(authTokenSecret)\n\n")
                
                let credential = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        // ...
                        print("\n\nTwitter Login Error : \(error.localizedDescription)\n\n")
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
            else {
                // ...
                print("Twitter Login Error: \(error?.localizedDescription)")
            }
            
        })
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
