//
//  Koting.swift
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

/// Contains four methods. Two of them are already implemented, they may be used to encode/decode objects of the type (struct or class) to/from a data. Remaining two methods must be implemented.
public protocol Koting {
    
    /// Encodes an object to a data.
    var de_data: Data? { get }
    
    /// Decodes a data to an object.
    ///
    /// - Parameter data: The data that an object of the given type was previously encoded to.
    /// - Returns: The object similar to the one that was previously encoded to the provided data.
    static func de_from(data: Data) -> Self?
    
    // MARK: - To Be Overriden
    
    /// Initializes an object based on a given coder.
    /// Needs to be implemented. Don't call this method directly.
    ///
    /// - Parameter koter: The coder containing the data to be taken to initialize the object.
    init?(koter: Koter)
    
    /// Populates a coder with all the data to be encoded.
    /// Needs to be implemented. Don't call this method directly.
    ///
    /// - Parameter koter: The coder which is supposed to consume the object's data.
    func enkot(with koter: Koter)
}

/// An extension which contains implementations of methods to convert the obect to `Data` and back.
public extension Koting {
   
    var de_data: Data? {
        let koter = Koter()
        enkot(with: koter)
        return NSKeyedArchiver.archivedData(withRootObject: koter.objects)
    }
    
    static func de_from(data: Data) -> Self? {
        guard let topObject = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as NSData),
            let objects = topObject as? [AnyHashable: Any] else {
                
            return nil
        }
        let coder = Koter(objects: objects)
        return Self(koter: coder)
    }
}
