//
//  FirebaseAuthFBLogin.swift
//  Firebase Auth
//
//  Created by Vasant Hugar on 07/07/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit
import Firebase

class FirebaseAuthFBLogin: NSObject {
    
    /// Call This from AppDelegate
    /// Then, in the application:didFinishLaunchingWithOptions: method, initialize the FirebaseApp object:
    static var configure: Void {
        FirebaseAuthConfigure.configure()
    }
    
    private static var obj: FirebaseAuthFBLogin?
    
    /// Get Instance of Model whenever required from ViewController
    static var shared: FirebaseAuthFBLogin {
        if obj == nil {
            obj = FirebaseAuthFBLogin()
        }
        return obj!
    }
    

}
