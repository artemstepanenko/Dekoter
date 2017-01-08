//
//  Koter.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 26/12/16.
//  Copyright (c) 2016 Artem Stepanenko <artem.stepanenko.1@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation


/// Collects a content of an object to be converted to Data and back – from Data to the initial type.
public class Koter {
    
    // MARK: - Property
    
    private(set) var objects: [AnyHashable: Any]
    
    // MARK: - Koting / Dekoting
    
    /// Decodes and returns an object that was previously encoded and associated with the string key.
    ///
    /// - Parameter key: the string key
    /// - Returns: the object that was previously encoded
    public func dekotObject<T>(forKey key: AnyHashable) -> T? {
        return objects[key] as? T
    }
    
    /// Decodes and returns an object which implements Koting that was previously encoded and associated with the string key.
    ///
    /// - Parameter key: the string key
    /// - Returns: the object which implements Koting that was previously encoded
    public func dekotObject<T: Koting>(forKey key: AnyHashable) -> T? {
        guard let data = objects[key] as? Data,
            let codingObject = T.de_from(data: data) else {
                
            return nil
        }
        return codingObject
    }
    
    /// Decodes and returns an array of objects which implement Koting that was previously encoded and associated with the string key.
    ///
    /// - Parameter key: the string key
    /// - Returns: the array of objects which implement Koting that was previously encoded
    public func dekotObject<T: Koting>(forKey key: AnyHashable) -> [T]? {
        guard let datas = objects[key] as? [Data] else {
            return nil
        }
        return datas.flatMap { T.de_from(data: $0) }
    }
    
    /// Encodes an object which implements Koting and associates it with the string key.
    ///
    /// - Parameters:
    ///   - object: the object which implements Koting
    ///   - key: the string key
    public func enkotObject<T: Koting>(_ object: T?, forKey key: AnyHashable) {
        guard let object = object, let data = object.de_data else {
            objects[key] = NSNull()
            return
        }
        objects[key] = data
    }
    
    /// Encodes an array of objects which implement Koting and associates it with the string key.
    ///
    /// - Parameters:
    ///   - object: the array of objects which implement Koting
    ///   - key: the string key
    public func enkotObject<T: Koting>(_ object: [T]?, forKey key: AnyHashable) {
        guard let object = object else {
            objects[key] = NSNull()
            return
        }
        objects[key] = object.flatMap { $0.de_data }
    }
    
    
    /// Encodes an object and associates it with the string key.
    ///
    /// - Parameters:
    ///   - object: the object
    ///   - key: the string key
    public func enkotObject<T>(_ object: T?, forKey key: AnyHashable) {
        guard let object = object else {
            objects[key] = NSNull()
            return
            
        }
        objects[key] = object
    }
    
    // MARK: - Initializer
    
    public convenience init() {
        self.init(objects: [:])
    }
    
    public required init(objects: [AnyHashable: Any]) {
        self.objects = objects
    }
}
