//
//  Koter.swift
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

public class Koter {
    
    // MARK: - Property
    
    fileprivate(set) var objects: [AnyHashable: Any]
    
    // MARK: - Koting / Dekoting
    
    func dekotObject<T>(forKey key: AnyHashable) -> T? {
        return objects[key] as? T
    }
    
    func dekotObject<T: Koting>(forKey key: AnyHashable) -> T? {
        guard let data = objects[key] as? Data,
            let codingObject = T.from(data: data) else {
                
            return nil
        }
        return codingObject
    }
    
    func dekotObject<T: Koting>(forKey key: AnyHashable) -> [T]? {
        guard let datas = objects[key] as? [Data] else {
            return nil
        }
        return datas.flatMap { T.from(data: $0) }
    }
    
    func enkotObject<T: Koting>(_ object: T?, forKey key: AnyHashable) {
        guard let object = object, let data = object.data else {
            objects[key] = NSNull()
            return
        }
        objects[key] = data
    }
    
    func enkotObject<T: Koting>(_ object: [T]?, forKey key: AnyHashable) {
        guard let object = object else {
            objects[key] = NSNull()
            return
        }
        objects[key] = object.flatMap { $0.data }
    }
    
    func enkotObject<T>(_ object: T?, forKey key: AnyHashable) {
        guard let object = object else {
            objects[key] = NSNull()
            return
            
        }
        objects[key] = object
    }
    
    // MARK: - Initializer
    
    public convenience init() {
        self.init(objects: [:])
    }
    
    public required init(objects: [AnyHashable: Any]) {
        self.objects = objects
    }
}
