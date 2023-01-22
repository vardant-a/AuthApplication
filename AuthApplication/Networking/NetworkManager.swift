//
//  NetworkManager.swift
//  AuthApplication
//
//  Created by Aleksei on 20.01.2023.
//

import UIKit
import FirebaseAuth
import Firebase

class NetworkManager {
    static let shared = NetworkManager()
    private let db = Firestore.firestore()
    let auth = Auth.auth()
    private var statusAuth = false
    
    func createAccount(email: String, password: String) {
        let animals: [Animal] = []
        
        self.auth.createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("Create user error")
                print(error?.localizedDescription ?? "174")
            } else {
                self.db.collection("users")
                    .addDocument(
                        data: ["uid": result!.user.uid,
                               "email": email,
                               "password": password,
                               "animals": animals
                              ]
                    ) { (error) in
                        if error != nil {
                            print("User date couldn`t")
                            print(error ?? "191")
                        }
                    }
            }
        }
    }
    
    func signIn(email: String, password: String) {
        self.auth
            .signIn(withEmail: email,
                    password: password) { (authResult, error) in
                
                guard error == nil else {
                    print("Error SignIn")
                    print(error?.localizedDescription ?? "Error SignIn")
                    return
                }
                
                
                guard let result = authResult else { return }
                print(result.user.email ?? "email - not found")
                print(result.user.uid)
                print("user SignIn")
        }
    }
    
    func checkStatusAuth(email: String, password: String) -> Bool {
        signIn(email: email, password: password)
        
        print("Cheack status Auth - \(statusAuth)")
        return statusAuth
    }
    
    func logOut() {
        do {
            try auth.signOut()
            print("LogOut - Win")
        } catch let signOutError as NSError {
            print("Error sigIng out: %@", signOutError)
        }
    }
    
    func deleteAccount() {
        
    }
}
