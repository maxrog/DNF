//
//  FileManager.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import Foundation

struct FileManager {
    
    /// fetch a plist to read from
    static func plist(named name: String, childName: String? = nil) -> [String : AnyObject] {
        let plistNotFound: [String : AnyObject] = [:]
        
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {
            return plistNotFound
        }
    
        guard let rootPlist = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> else {
            return plistNotFound
        }
        
        // if we want to drill down into the plist
        if let childName {
            return rootPlist[childName] as? [String : AnyObject] ?? plistNotFound
        }
        
        return rootPlist
    }
    
}
