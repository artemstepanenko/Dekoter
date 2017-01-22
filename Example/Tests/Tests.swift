//
//  Tests.swift
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

import UIKit
import XCTest
import Dekoter

class Tests: XCTestCase {
    
    func testMissingSurname_AfterDecoding_StaysMissing() {
        let murzik = Cat(name: "Murzik", surname: nil, sex: .male, nationality: "UKR", birthPlace: nil)
        
        guard let data = murzik.de_data, let againMurzik = Cat.de_from(data: data) else {
            XCTFail()
            return
        }
        
        XCTAssertNil(againMurzik.surname)
    }
    
    func testPuff_AfterDecoding_StaysPuff() {
        let puff = Cat(name: "Puff", surname: nil, sex: .female, nationality: "US", birthPlace: nil)
        
        guard let data = puff.de_data, let againPuff = Cat.de_from(data: data) else {
            XCTFail()
            return
        }
        
        let expected = "Puff"
        let actual = againPuff.name
        XCTAssertEqual(expected, actual)
    }
    
    func testBirthPlace_AfterDecoding_StaysSame() {
        let kharkiv = Place(country: "Ukraine", city: "Kharkiv")
        let murzik = Cat(name: "Murzik", surname: nil, sex: .male, nationality: "UKR", birthPlace: kharkiv)
        
        guard let data = murzik.de_data, let againMurzik = Cat.de_from(data: data),
            let againKharkiv = againMurzik.birthPlace else {
            
            XCTFail()
            return
        }
        
        let expected = "Kharkiv"
        let actual = againKharkiv.city
        XCTAssertEqual(expected, actual)
    }
}
