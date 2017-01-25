//
//  DekoterTests.swift
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

import XCTest
import Dekoter

class DekoterTests: XCTestCase {
    
    func testPuff_AfterDekoting_StaysTheSame() {
        let puff: Cat = Cat(name: "Puff", surname: nil, sex: .female, nationality: "US", birthPlace: nil)
        
        guard let data = puff.de_data else {
            XCTFail("Failed to convert Puff to Data")
            return
        }
        
        guard let againPuff = Cat.de_from(data: data) else {
            XCTFail("Failed to convert Data to Puff")
            return
        }
        
        XCTAssertEqual(againPuff, puff)
    }

    func testEmma_AfterDekoting_StaysTheSame() {
        let emma: Cat = Cat(name: "Emma", surname: "Lambert", sex: .female, nationality: "FR", birthPlace: Place(country: "France", city: "Marseille"))
        
        guard let data = emma.de_data else {
            XCTFail("Failed to convert Emma to Data")
            return
        }
        
        guard let againEmma = Cat.de_from(data: data) else {
            XCTFail("Failed to convert Data to Emma")
            return
        }
        
        XCTAssertEqual(againEmma, emma)
    }

    func testBerlin_AfterDekoting_StaysTheSame() {
        let berlin: Place = Place(country: "Germany", city: "Berlin")
        
        guard let data = berlin.de_data else {
            XCTFail("Failed to convert Berlin to Data")
            return
        }
        
        guard let againBerlin = Place.de_from(data: data) else {
            XCTFail("Failed to convert Data to Berlin")
            return
        }
        
        XCTAssertEqual(againBerlin, berlin)
    }
}
