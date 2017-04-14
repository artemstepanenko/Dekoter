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
            throw NSError(domain: "Dekoter", code: 5001, userInfo: ["NSDebugDescription": "JSON object is not a dictionary."])
        }
        
        let coder = JSONKoter(objects: dict)
        guard let result = T(koter: coder) else {
            throw NSError(domain: "Dekoter", code: 5002, userInfo: ["NSDebugDescription": "JSON object doesn't conform to the requested type."])
        }
        return result
    }
}
