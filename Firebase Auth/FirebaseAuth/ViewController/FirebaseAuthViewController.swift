//
//  FirebaseAuthViewController.swift
//  Firebase Auth
//
//  Created by Vasant Hugar on 06/07/17.
//  Copyright © 2017 Rahul Sharma. All rights reserved.
//

import UIKit
import Firebase

enum FirebaseAuthType: Int {
    case email = 0
    case google = 1
    case facebook = 2
    case twitter = 3
    case github = 4
    case anonymous = 5
}

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
}

extension FirebaseAuthViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch FirebaseAuthType(rawValue: section)! {
        case .google, .facebook, .twitter, .github, .anonymous:
            return 1
            
        default:
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch FirebaseAuthType(rawValue: indexPath.section)! {
        case .google:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirebaseAuthTableViewCell") as! FirebaseAuthTableViewCell
            
            cell.action.text = "Google Signin"
            return cell
            
        case .facebook:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirebaseAuthTableViewCell") as! FirebaseAuthTableViewCell
            
            cell.action.text = "Login with Facebook"
            return cell
            
        case .twitter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirebaseAuthTableViewCell") as! FirebaseAuthTableViewCell
            
            cell.action.text = "Login with Twitter"
            return cell
            
        case .github:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirebaseAuthTableViewCell") as! FirebaseAuthTableViewCell
            
            cell.action.text = "Login with Github"
            return cell
            
        case .anonymous:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirebaseAuthTableViewCell") as! FirebaseAuthTableViewCell
            
            cell.action.text = "Anonymous"
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirebaseAuthTableViewCell") as! FirebaseAuthTableViewCell
            
            cell.action.text = actions(type: FirebaseActionType(rawValue: indexPath.row)!).title
            return cell
        }
    }
}

extension FirebaseAuthViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch FirebaseAuthType(rawValue: section)! {
        case .email:
            return "Email"
            
        case .google:
            return "Google"
            
        case .facebook:
            return "Facebook"
            
        case .twitter:
            return "Twitter"
            
        case .github:
            return "GitHub"
            
        case .anonymous:
            return "Anonymous"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch FirebaseAuthType(rawValue: indexPath.section)! {
        case .email:
            
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
                firebase.updateEmail(email: "vasanthugar@gmail.com")
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
            break
            
        case .google:
            performSegue(withIdentifier: "googleSegue", sender: nil)
            break
            
        case .facebook:
            performSegue(withIdentifier: "facebookSegue", sender: nil)
            break
            
        case .twitter:
            performSegue(withIdentifier: "twitterSegue", sender: nil)
            break
            
        case .github:
            //performSegue(withIdentifier: "facebookSegue", sender: nil)
            break
            
        case .anonymous:
            anonymous()
            break

        }
    }
    
    func anonymous() {
        
        Auth.auth().signInAnonymously() { (user, error) in
            // ...
            let isAnonymous = user!.isAnonymous  // true
            print("IsAnonymous: \(isAnonymous)")
            
            let uid = user!.uid
            print("User id: \(uid)")
        }
    }
}

