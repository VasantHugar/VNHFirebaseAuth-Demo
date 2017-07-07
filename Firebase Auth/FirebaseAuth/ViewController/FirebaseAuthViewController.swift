//
//  FirebaseAuthViewController.swift
//  Firebase Auth
//
//  Created by 3Embed on 06/07/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit

enum FirebaseActionType: Int {
    case createUser = 0
    case signin = 1
    case profileChange = 2
    case updateEmail = 3
    case sendEmailVerification = 4
    case updatePassword = 5
    case sendPasswordReset = 6
    case delete = 7
}

class FirebaseAuthViewController: UIViewController {
    
    let firebase = FirebaseAuthModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       firebase.addChangeListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firebase.removeChangeListener()
    }
    
    func actions(type: FirebaseActionType) -> (title: String, segueIdentifier: String) {
        
        switch type {
        case .createUser:
            return ("Create User", "")
            
        case .signin:
            return ("Signin", "")
            
        case .profileChange:
            return ("Profile Change", "")
            
        case .updateEmail:
            return ("Update Email", "")
            
        case .sendEmailVerification:
            return ("Send Email Verification", "")
            
        case .updatePassword:
            return ("Update Password", "")
            
        case .sendPasswordReset:
            return ("Password Reset", "")
            
        case .delete:
            return ("Delete", "")
            
        }
    }
    
    
    /*
    func createUser(email: String, password: String) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            
            // ...
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                // ...
            }
        }
        
    }
    
    func signin(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            // ...
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                // ...
            }
        }
    }
    
    func createProfileChange(displayName: String, photoURL: String) {
        
        let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
        
        changeRequest?.displayName = "Vasant Hugar"
        
        changeRequest?.photoURL = URL(string: "https://www.google.co.in/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=0ahUKEwivlsawkfTUAhXHLI8KHb-TAvUQjRwIBw&url=http%3A%2F%2Fappleiphonenew.com%2Fapple-developer%2F&psig=AFQjCNE6IV3_UWy9SWNGaQqKiCJ8uYYLrQ&ust=1499412605426053")
        changeRequest?.commitChanges { (error) in
            // ...
        }
    }
    
    func updateEmail(email: String) {
        FIRAuth.auth()?.currentUser?.updateEmail(email) { (error) in
            // ...
        }
    }
    
    func sendEmailVerification() {
        FIRAuth.auth()?.currentUser?.sendEmailVerification { (error) in
            // ...
        }
    }
    
    func updatePassword(password: String) {
        
        FIRAuth.auth()?.currentUser?.updatePassword(password) { (error) in
            // ...
        }
    }
    
    func sendPasswordReset(email: String) {
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email) { (error) in
            // ...
        }
    }
    
    func delete() {
        
        let user = FIRAuth.auth()?.currentUser
        
        user?.delete { error in
            
            if error != nil {
                // An error happened.
            }
            else {
                // Account deleted.
            }
        }
    }
 */
}

extension FirebaseAuthViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirebaseAuthTableViewCell") as! FirebaseAuthTableViewCell
        
        cell.action.text = actions(type: FirebaseActionType(rawValue: indexPath.row)!).title
        
        return cell
    }
}

extension FirebaseAuthViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch FirebaseActionType(rawValue: indexPath.row)! {
        case .createUser:
            firebase.createUser(email: "hugar.vasant@gmail.com", password: "3Embed")
            break
            
        case .signin:
            firebase.signin(email: "hugar.vasant@gmail.com", password: "3Embed")
            break
            
        case .profileChange:
            firebase.profileChange(displayName: "Vasant", photoURL: "")
            break
            
        case .updateEmail:
            firebase.updateEmail(email: "vasant@mobifyi.com")
            break
            
        case .sendEmailVerification:
            firebase.sendEmailVerification()
            break
            
        case .updatePassword:
            firebase.updatePassword(password: "1234")
            break
            
        case .sendPasswordReset:
            firebase.sendPasswordReset(email: "vasant@mobifyi.com")
            break
            
        case .delete:
            firebase.delete()
            break
        }
    }
}

