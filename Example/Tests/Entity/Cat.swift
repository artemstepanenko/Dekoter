//
//  Cat.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 31/12/16.
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

struct Cat {
    
    enum Sex: Int {
        case male
        case female
    }
    
    let name: String
    let surname: String?
    let sex: Sex
    let nationality: String
    let birthPlace: Place?
}

// MARK: - Koting

extension Cat: Koting {
    
    private struct Key {
        static let name = "name"
        static let surname = "surname"
        static let sex = "sex"
        static let nationality = "nationality"
        static let birthPlace = "birthPlace"
    }
    
    init?(koter: Koter) {
        guard let name: String = koter.dekotObject(forKey: Key.name),
            let nationality: String = koter.dekotObject(forKey: Key.nationality),
            let sexValue: Int = koter.dekotObject(forKey: Key.sex),
            let sex = Sex(rawValue: sexValue) else {
                
            return nil
        }
        let surname: String? = koter.dekotObject(forKey: Key.surname)
        let birthPlace: Place? = koter.dekotObject(forKey: Key.birthPlace)
        self.init(name: name, surname: surname, sex: sex, nationality: nationality, birthPlace: birthPlace)
    }
    
    func enkot(with koter: Koter) {
        koter.enkotObject(name, forKey: Key.name)
        koter.enkotObject(surname, forKey: Key.surname)
        koter.enkotObject(sex.rawValue, forKey: Key.sex)
        koter.enkotObject(nationality, forKey: Key.nationality)
        koter.enkotObject(birthPlace, forKey: Key.birthPlace)
    }
}
