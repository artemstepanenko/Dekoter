//
//  PlaceTests.swift
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

class PlaceTests: XCTestCase {
    
    func test_TwoMissingPlaces_AreEqual() {
        let firstMissingPlace: Place? = nil
        let secondMissingPlace: Place? = nil
        XCTAssertEqual(firstMissingPlace, secondMissingPlace)
    }
    
    func test_MissingPlaceAndNot_AreNotEqual() {
        let missingPlace: Place? = nil
        let paris: Place? = Place(country: "France", city: "Paris")
        XCTAssertNotEqual(missingPlace, paris)
    }

    func test_TwoDifferentPlaces_AreNotEqual() {
        let palermo: Place = Place(country: "Italy", city: "Palermo")
        let porto: Place = Place(country: "Portugal", city: "Porto")
        XCTAssertNotEqual(palermo, porto)
    }
    
    func test_TwoSimilarPlaces_AreEqual() {
        let kharkiv: Place = Place(country: "Ukraine", city: "Kharkiv")
        let againKharkiv: Place = Place(country: "Ukraine", city: "Kharkiv")
        XCTAssertEqual(kharkiv, againKharkiv)
    }
}
