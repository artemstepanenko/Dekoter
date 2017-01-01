//
//  Person.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 27/12/16.
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
@testable import Dekoter

struct Person {
    let name: String
    let age: Int?
    let residence: Residence?
    
    init(name: String, age: Int? = nil, residence: Residence? = nil) {
        self.name = name
        self.age = age
        self.residence = residence
    }
}

// MARK: - Koting

extension Person: Koting {
    
    init?(koter: Koter) {
        let name: String = koter.dekotObject(forKey: "name")!
        let age: Int? = koter.dekotObject(forKey: "age")
        let residence: Residence? = koter.dekotObject(forKey: "residence")
        self.init(name: name, age: age, residence: residence)
    }
    
    func enkot(with koter: Koter) {
        koter.enkotObject(name, forKey: "name")
        koter.enkotObject(age, forKey: "age")
        koter.enkotObject(residence, forKey: "residence")
    }
}
