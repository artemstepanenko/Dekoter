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

/// Structs and classes which implement this protocol may be used in conjunction with
/// extensions from the `Dekoter` library.
///
/// - To save objects to `UserDefaults`.
/// - To deserialize objects from JSON.
/// - To convert objects to `Data` (archive) and back (unarchive).
public protocol Koting: Dekoting, Enkoting {
}

/// Is used for decoding (or deserialization).
public protocol Dekoting {
    
    /// Initializes an object based on a given coder.
    /// Needs to be implemented. Don't call this method directly.
    ///
    /// - Parameter koter: The coder containing the data to be taken to initialize the object.
    init?(koter: Koter)
}

/// Is used for encoding (or serialization).
public protocol Enkoting {
    
    /// Populates a coder with all the data to be encoded.
    /// Needs to be implemented. Don't call this method directly.
    ///
    /// - Parameter koter: The coder which is supposed to consume the object's data.
    func enkot(with koter: Koter)
}
