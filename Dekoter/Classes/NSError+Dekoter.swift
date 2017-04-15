//
//  NSError+Dekoter.swift
//  Pods
//
//  Created by Artem Stepanenko on 15/04/17.
//
//

import Foundation

extension NSError {
    
    // MARK: - JSON
    
    static var jsonObjectIsNotDictionaryError: NSError {
        return NSError(domain: "Dekoter", code: 5001, userInfo: ["NSDebugDescription": "JSON object is not a dictionary."])
    }
    
    static var jsonObjectDoesNotConformToTypeError: NSError {
        return NSError(domain: "Dekoter", code: 5002, userInfo: ["NSDebugDescription": "JSON object doesn't conform to the requested type."])
    }
    
    static var jsonObjectIsNotArrayError: NSError {
        return NSError(domain: "Dekoter", code: 5003, userInfo: ["NSDebugDescription": "JSON object is not an array of dictionaries."])
    }
    
    // MARK: - Unarchiving
    
    static var unarchivingObjectIsNotDictionaryError: NSError {
        return NSError(domain: "Dekoter", code: 5004, userInfo: ["NSDebugDescription": "Top level object must be a dictionary."])
    }
    
}
