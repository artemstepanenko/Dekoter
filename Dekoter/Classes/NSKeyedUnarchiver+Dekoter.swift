//
//  NSKeyedUnarchiver+Dekoter.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 31/01/17.
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

/// An `NSKeyedUnarchiver` extension to unarchive objects which implement the `Koting` protocol.
public extension NSKeyedUnarchiver {
    
    /// Unarchives an object which implements the `Koting` protocol from the given data.
    ///
    /// - Parameter data: The archived object.
    /// - Returns: The object similar to the one that was previously archived.
    public class func de_unarchiveObject<T: Koting>(with data: Data) -> T? {
        guard let topObject = try? unarchiveTopLevelObjectWithData(data),
            let objects = topObject as? [AnyHashable: Any] else {
                
            return nil
        }
        let coder = Koter(objects: objects)
        return T(koter: coder)
    }
    
    /// Unarchives an array of objects which implement the `Koting` protocol.
    ///
    /// - Parameter data: The data that an object of the given type was previously encoded to.
    /// - Returns: The array similar to the one that was previously encoded to the provided data.
    public class func de_unarchiveObject<T: Koting>(with data: Data) -> [T]? {
        guard let datas = unarchiveObject(with: data) as? [Data] else {
            return nil
        }
        return datas.flatMap { de_unarchiveObject(with: $0) }
    }
}
