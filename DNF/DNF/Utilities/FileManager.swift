//
//  FileManager.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import Foundation

class FileManager {
    
    /// fetch a plist to read from
    static func plist(named name: String, childName: String? = nil) -> [String : AnyHashable] {
        let plistNotFound: [String : AnyHashable] = [:]
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {
            return plistNotFound
        }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else {
            return plistNotFound
        }
        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String:AnyHashable] else {
            return plistNotFound
        }
        
        // if we want to drill down into the plist
        if let childName = childName {
            return plist[childName] as? [String : AnyHashable] ?? plistNotFound
        }
        
        return plist
    }
    
}
