//
//  KeychainManager.swift
//  DNF
//
//  Created by Max Rogers on 6/12/22.
//

import Foundation

/*
 Helper to make keychain storage/queries easier
 
 Generic functions that work with any Codable conforming object
 */

enum KeychainAccount: String {
    case strava
}
enum KeychainService: String {
    case standard = "rogers.max.DNF.app"
}

class KeychainManager {
    
    static let shared = KeychainManager()
    private init() {}
    
    func save<T>(_ item: T, service: KeychainService = .standard, account: KeychainAccount) where T : Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, service: .standard, account: account)
            
        } catch {
            let message = "Failed to encode item for keycahin: \(error.localizedDescription)"
            DNFLogger.log(.fatal, message, sender: String(describing: self))
        }
    }
    
    func fetch<T>(service: KeychainService = .standard, account: KeychainAccount, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = fetch(service: service, account: account) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            let message = "Failed to decode item for keycahin: \(error.localizedDescription)"
            DNFLogger.log(.fatal, message, sender: String(describing: self))
            return nil
        }
    }
    
    func delete(service: KeychainService = .standard, account: KeychainAccount) {
        
        let query = [
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }

}

extension KeychainManager {
    
    private func save(_ data: Data, service: KeychainService, account: KeychainAccount) {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: service.rawValue,
                kSecAttrAccount: account.rawValue,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary

            let attributesToUpdate = [kSecValueData: data] as CFDictionary

            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
        } else if status != errSecSuccess {
            let message = "Error: \(status)"
            DNFLogger.log(.fatal, message, sender: String(describing: self))
        }
    }
    
    private func fetch(service: KeychainService, account: KeychainAccount) -> Data? {
        
        let query = [
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
}
