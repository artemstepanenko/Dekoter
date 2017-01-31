//
//  NSKeyedArchiverTests.swift
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

import XCTest
import Dekoter

class NSKeyedArchiverTests: XCTestCase {
    
    func testPuff_AfterDekoting_StaysTheSame() {
        let puff = Cat(name: "Puff", surname: nil, sex: .female, nationality: "US", birthPlace: nil)
        let data = NSKeyedArchiver.de_archivedData(withRootObject: puff)

        guard let againPuff: Cat = NSKeyedUnarchiver.de_unarchiveObject(with: data) else {
            XCTFail("Failed to convert Data to Puff")
            return
        }
        
        XCTAssertEqual(againPuff, puff)
    }
    
    func testEmma_AfterDekoting_StaysTheSame() {
        let emma = Cat(name: "Emma", surname: "Lambert", sex: .female, nationality: "FR",
                       birthPlace: Place(country: "France", city: "Marseille"))
        let data = NSKeyedArchiver.de_archivedData(withRootObject: emma)
        
        guard let againEmma: Cat = NSKeyedUnarchiver.de_unarchiveObject(with: data) else {
            XCTFail("Failed to convert Data to Emma")
            return
        }
        
        XCTAssertEqual(againEmma, emma)
    }
    
    func testBerlin_AfterDekoting_StaysTheSame() {
        let berlin = Place(country: "Germany", city: "Berlin")
        let data = NSKeyedArchiver.de_archivedData(withRootObject: berlin)
        
        guard let againBerlin: Place = NSKeyedUnarchiver.de_unarchiveObject(with: data) else {
            XCTFail("Failed to convert Data to Berlin")
            return
        }
        
        XCTAssertEqual(againBerlin, berlin)
    }
}

// MARK: - Array

extension NSKeyedArchiverTests {
    
    func testEmptyCatsArray_AfterDekoting_StaysTheSame() {
        let noCats: [Cat] = []
        let data = NSKeyedArchiver.de_archivedData(withRootObject: noCats)
        
        guard let againNoCats: [Cat] = NSKeyedUnarchiver.de_unarchiveObject(with: data) else {
            XCTFail("Failed to convert Data to cats")
            return
        }
        
        XCTAssertEqual(againNoCats, noCats)
    }
    
    func testOneCatArray_AfterDekoting_ContainsTheSameCat() {
        let emma = Cat(name: "Emma", surname: "Lambert", sex: .female, nationality: "FR",
                       birthPlace: Place(country: "France", city: "Marseille"))
        
        let cats = [ emma ]
        let data = NSKeyedArchiver.de_archivedData(withRootObject: cats)
        
        guard let againCats: [Cat] = NSKeyedUnarchiver.de_unarchiveObject(with: data) else {
            XCTFail("Failed to convert Data to cats")
            return
        }
        
        XCTAssertEqual(againCats, cats)
    }
    
    func testTwoCatsArray_AfterDekoting_ContainsTheSameCats() {
        let sonya = Cat(name: "Sonya", surname: "Kryvonis", sex: .female, nationality: "UA",
                        birthPlace: Place(country: "Ukraine", city: "Lviv"))
        let puff: Cat = Cat(name: "Puff", surname: nil, sex: .female, nationality: "US", birthPlace: nil)
        
        let cats = [ sonya, puff ]
        let data = NSKeyedArchiver.de_archivedData(withRootObject: cats)
        
        guard let againCats: [Cat] = NSKeyedUnarchiver.de_unarchiveObject(with: data) else {
            XCTFail("Failed to convert Data to cats")
            return
        }
        
        XCTAssertEqual(againCats, cats)
    }
}
