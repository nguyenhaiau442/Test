//
//  DataManager.swift
//  Test
//
//  Created by Nguyễn Hải Âu on 10/21/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit
import KeychainSwift

class DataManager {
    
    // singleton
    private static var sharedDataManager: DataManager = {
        let dataManager = DataManager()
        return dataManager
    }()
    
    class func shared() -> DataManager {
        return sharedDataManager
    }
    
    let accessTokenKey = "accessTokenKey"
    
    func saveAccessToken(accessToken: String) {
        let keychain = KeychainSwift()
        keychain.set(accessToken, forKey: accessTokenKey)
    }
    
    func getAccessToken() {
        let keychain = KeychainSwift()
        if let accessToken = keychain.get(accessTokenKey) {
            print(accessToken)
        }
    }
}
