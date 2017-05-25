//
//  JSONSerialization+Dekoter.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 14/04/17.
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

/// An `JSONSerialization` extension to deserialize objects which implement the `Koting` protocol from JSON.
extension JSONSerialization {
    
    /// Creates an object which implements the `Koting` protocol from JSON data.
    ///
    /// - Parameters:
    ///   - data: JSON data.
    ///   - opt: Options.
    /// - Returns: A deserialized object.
    class func de_jsonObject<T: Dekoting>(with data: Data, options opt: JSONSerialization.ReadingOptions = []) -> T? {
        guard let object = try? jsonObject(with: data, options: opt),
            let dict = object as? [AnyHashable: Any] else {
            
            return nil
        }
        return de_serializedObject(from: dict)
    }
    
    /// Creates an array of objects which implement the `Koting` protocol from JSON data.
    ///
    /// - Parameters:
    ///   - data: JSON data.
    ///   - opt: Options.
    /// - Returns: A deserialized array.
    class func de_jsonObject<T: Dekoting>(with data: Data, options opt: JSONSerialization.ReadingOptions = []) -> [T]? {
        guard let object = try? jsonObject(with: data, options: opt),
            let dicts = object as? [[AnyHashable: Any]] else {
            
            return nil
        }
        return dicts.flatMap { de_serializedObject(from: $0) }
    }
}

// MARK: - Private

fileprivate extension JSONSerialization {
    
    class func de_serializedObject<T: Dekoting>(from dict: [AnyHashable: Any]) -> T? {
        let coder = JSONKoter(objects: dict)
        guard let object = T(koter: coder) else {
            return nil
        }
        return object
    }
}
