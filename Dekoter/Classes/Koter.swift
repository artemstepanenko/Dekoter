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
    /// - Parameter key: The string key.
    /// - Returns: The object that was previously encoded.
    public func dekotObject<T>(forKey key: AnyHashable) -> T? {
        return objects[key] as? T
    }
    
    /// Decodes and returns an object which implements Koting that was previously encoded and associated with the string key.
    ///
    /// - Parameter key: The string key.
    /// - Returns: The object which implements the `Koting` protocol that was previously encoded.
    public func dekotObject<T: Koting>(forKey key: AnyHashable) -> T? {
        guard let dict = objects[key] as? [AnyHashable: Any] else {
            return nil
        }
        return object(from: dict)
    }
    
    /// Decodes and returns an array of objects which implement Koting that was previously encoded and associated with the string key.
    ///
    /// - Parameter key: The string key.
    /// - Returns: The array of objects which implement the `Koting` protocol that was previously encoded.
    public func dekotObject<T: Koting>(forKey key: AnyHashable) -> [T]? {
        guard let objects = objects[key] as? [Any] else {
            return nil
        }
        return objects.flatMap { object(from: $0 as? [AnyHashable: Any]) }
    }
    
    /// Encodes an object which implements the `Koting` protocol and associates it with the string key.
    ///
    /// - Parameters:
    ///   - object: The object which implements Koting.
    ///   - key: The string key.
    public func enkotObject(_ object: Koting?, forKey key: AnyHashable) {
        guard let object = object else {
            return
        }
        objects[key] = dict(from: object)
    }
    
    /// Encodes an array of objects which implement the `Koting` protocol and associates it with the string key.
    ///
    /// - Parameters:
    ///   - object: The array of objects which implement the `Koting` protocol.
    ///   - key: The string key.
    public func enkotObject(_ object: [Koting]?, forKey key: AnyHashable) {
        guard let object = object else {
            return
        }
        objects[key] = object.map { dict(from: $0) }
    }
    
    /// Encodes an object and associates it with the string key.
    ///
    /// - Parameters:
    ///   - object: The object.
    ///   - key: The string key.
    public func enkotObject(_ object: Any?, forKey key: AnyHashable) {
        guard let object = object else {
            return
            
        }
        objects[key] = object
    }
    
    // MARK: - Initializer
    
    /// An initializer without params
    public convenience init() {
        self.init(objects: [:])
    }
    
    /// An initializer which takes objects to store.
    public required init(objects: [AnyHashable: Any]) {
        self.objects = objects
    }
}

// MARK: - Private

fileprivate extension Koter {
    
    func object<T: Koting>(from dict: [AnyHashable: Any]?) -> T? {
        guard let dict = dict else {
            return nil
        }
        let koter = Koter(objects: dict)
        return T(koter: koter)
    }
    
    func dict(from object: Koting?) -> [AnyHashable: Any]? {
        guard let object = object else {
            return nil
        }
        let koter = Koter()
        object.enkot(with: koter)
        return koter.objects
    }
}
