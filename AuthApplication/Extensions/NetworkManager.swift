//
//  NetworkManager.swift
//  AuthApplication
//
//  Created by Aleksei on 20.01.2023.
//

import Foundation
import FirebaseAuth
import Firebase

class NetworkManager {
    static let shared = NetworkManager()
    private let db = Firestore.firestore()
    
    func createAccount(email: String, password: String) {
        let animals: [Animal] = []
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("Create user error")
                print(error?.localizedDescription ?? "174")
            } else {
                self.db.collection("user")
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
        
    }
    
    func logOut() {
        
    }
    
    func deleteAccount() {
        
    }
}
