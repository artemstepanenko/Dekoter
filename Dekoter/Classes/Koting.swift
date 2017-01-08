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


/// Declares four methods. Two of them are already implemented, they may be used to encode/decode objects of the type (struct or class) to/from a data. Remaining two methods must be implemented.
public protocol Koting {
    
    var de_data: Data? { get }
    static func de_from(data: Data) -> Self?
    
    // MARK: - To Be Overriden
    
    init?(koter: Koter)
    func enkot(with koter: Koter)
}

public extension Koting {
   
    /// Tries to encode an object to a data. (Returns nil, if the object contains a property of an unsupported type.)
    var de_data: Data? {
        let koter = Koter()
        enkot(with: koter)
        return NSKeyedArchiver.archivedData(withRootObject: koter.objects)
    }
    
    
    /// Tries to decode a data to an object.
    ///
    /// - Parameter data: the data that an object of the given type was previously encoded to
    /// - Returns: the object similar to the one that was previously encoded to the provided data. Returns nil, if the data was created differently.
    static func de_from(data: Data) -> Self? {
        guard let topObject = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as NSData),
            let objects = topObject as? [AnyHashable: Any] else {
                
            return nil
        }
        let coder = Koter(objects: objects)
        return Self(koter: coder)
    }
}
