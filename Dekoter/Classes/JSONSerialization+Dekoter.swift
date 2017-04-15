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

extension JSONSerialization {
    
    class func de_jsonObject<T: Koting>(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> T {
        let object = try jsonObject(with: data, options: opt)
        guard let dict = object as? [AnyHashable: Any] else {
            throw NSError.jsonObjectIsNotDictionaryError
        }
        return try de_serializedObject(from: dict)
    }
    
    class func de_jsonObject<T: Koting>(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> [T] {
        let object = try jsonObject(with: data, options: opt)
        guard let dicts = object as? [[AnyHashable: Any]] else {
            throw NSError.jsonObjectIsNotArrayError
        }
        return try dicts.map { try de_serializedObject(from: $0) }
    }
}

// MARK: - Private

fileprivate extension JSONSerialization {
    
    class func de_serializedObject<T: Koting>(from dict: [AnyHashable: Any]) throws -> T {
        let coder = JSONKoter(objects: dict)
        guard let object = T(koter: coder) else {
            throw NSError.jsonObjectDoesNotConformToTypeError
        }
        return object
    }
}
