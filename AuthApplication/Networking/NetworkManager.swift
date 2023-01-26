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
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private var verificationId: String?
    
    private var statusAuth = false
    
    public func startAuth(phoneNumber: String, completion: @escaping(Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationId, error) in
            guard let verificationId = verificationId, error == nil else {
                print(error!.localizedDescription)
                completion(false)
                return
            }
            self?.verificationId = verificationId
            completion(true)
        }
    }
    
    public func verityCode(smsCode: String, completion: @escaping(Bool) -> Void) {
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
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
