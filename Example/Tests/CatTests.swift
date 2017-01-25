//
//  CatTests.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 22/01/17.
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

class CatTests: XCTestCase {
    
    func test_TwoMissingCats_AreEqual() {
        let firstMissingCat: Cat? = nil
        let secondMissingCat: Cat? = nil
        XCTAssertEqual(firstMissingCat, secondMissingCat)
    }
    
    func test_MissingCatAndNot_AreNotEqual() {
        let missingCat: Cat? = nil
        let charlie: Cat? = Cat(name: "Charlie", surname: "Tompson", sex: .male, nationality: "US", birthPlace: nil)
        XCTAssertNotEqual(missingCat, charlie)
    }
    
    func test_TwoDifferentCats_AreNotEqual() {
        let charlie: Cat = Cat(name: "Charlie", surname: "Tompson", sex: .male, nationality: "US", birthPlace: nil)
        let sonya: Cat = Cat(name: "Sonya", surname: "Kryvonis", sex: .female, nationality: "UA", birthPlace: Place(country: "Ukraine", city: "Lviv"))
        XCTAssertNotEqual(charlie, sonya)
    }
    
    func test_TwoSimilarCats_AreEqual() {
        let emma: Cat = Cat(name: "Emma", surname: "Lambert", sex: .female, nationality: "FR", birthPlace: Place(country: "France", city: "Marseille"))
        let againEmma: Cat = Cat(name: "Emma", surname: "Lambert", sex: .female, nationality: "FR", birthPlace: Place(country: "France", city: "Marseille"))
        XCTAssertEqual(emma, againEmma)
    }
}
