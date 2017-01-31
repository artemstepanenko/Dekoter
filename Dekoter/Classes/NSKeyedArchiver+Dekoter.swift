//
//  NSKeyedArchiver+Dekoter.swift
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

/// An `NSKeyedArchiver` extension to unarchive objects which implement the `Koting` protocol.
public extension NSKeyedArchiver {
    
    /// Archives an object which implement the `Koting` protocol to `Data`.
    ///
    /// - Parameter rootObject: The object which implement the `Koting` protocol.
    /// - Returns: The archived object.
    public class func de_archivedData(withRootObject rootObject: Koting) -> Data {
        let koter = Koter()
        rootObject.enkot(with: koter)
        return archivedData(withRootObject: koter.objects)
    }
    
    /// Archives an array.
    ///
    /// - Parameter rootObject: The array of objects which implement the `Koting` protocol.
    /// - Returns: The archived array.
    public class func de_archivedData(withRootObject rootObject: [Koting]) -> Data {
        let datas = rootObject.map { de_archivedData(withRootObject: $0) }
        return archivedData(withRootObject: datas)
    }
}
