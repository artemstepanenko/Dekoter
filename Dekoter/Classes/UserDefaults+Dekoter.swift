//
//  UserDefaults+Dekoter.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 16/01/17.
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

/// A handy `UserDefaults` extension to save/load objects which implement the `Koting` protocol.
public extension UserDefaults {
    
    /// Sets the value of the specified default key to the specified object which implements the `Koting` protocol.
    ///
    /// - Parameters:
    ///   - value: The object which implements Koting to store in the defaults database.
    ///   - defaultName: The key with which to associate with the value.
    public func de_set(_ value: Koting?, forKey defaultName: String) {
        guard let value = value else {
            return
        }
        let data = NSKeyedArchiver.de_archivedData(withRootObject: value)
        set(data, forKey: defaultName)
    }
    
    /// Returns the object which implements the `Koting` protocol associated with the specified key.
    ///
    /// - Parameter defaultName: A key in the current user's defaults database.
    /// - Returns: The object which implements the `Koting` protocol.
    public func de_object<T: Koting>(forKey defaultName: String) -> T? {
        guard let data = object(forKey: defaultName) as? Data else {
            return nil
        }
        return NSKeyedUnarchiver.de_unarchiveObject(with: data)
    }
}
