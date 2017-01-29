//
//  Array+Dekoter.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 25/01/17.
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

/// An extension `Array` of objects which implement the `Koting` protocol.
/// Allows to convert an array to `Data` and back.
public extension Array where Element: Koting {
    
    /// Encodes an array to a data.
    public var de_data: Data? {
        let datas = flatMap { $0.de_data }
        return NSKeyedArchiver.archivedData(withRootObject: datas)
    }
    
    /// Decodes a data to an array.
    ///
    /// - Parameter data: The data that an object of the given type was previously encoded to.
    /// - Returns: The array similar to the one that was previously encoded to the provided data.
    public static func de_from(data: Data) -> [Element]? {
        guard let datas = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Data] else {
            return nil
        }
        return datas.flatMap { Element.de_from(data: $0) }
    }
}
