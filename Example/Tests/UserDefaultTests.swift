//
//  UserDefaultTests.swift
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

import XCTest
import Dekoter

// TODO: find a better way to test this
class UserDefaultTests: XCTestCase {
    
    let userDefaults = UserDefaults.standard
    
    override func tearDown() {
        userDefaults.removeObject(forKey: Key.cat)
        super.tearDown()
    }
    
    func testUserDefaults_IfNilSaved_RemovesObject() {
        let puff: Cat = Cat(name: "Puff", surname: nil, sex: .female, nationality: "US", birthPlace: nil)
        
        userDefaults.de_set(puff, forKey: Key.cat)
        userDefaults.de_set(nil as Cat?, forKey: Key.cat)
        
        let cat: Cat? = userDefaults.de_object(forKey: Key.cat)
        XCTAssertNil(cat)
    }

    
    func testUserDefaults_IfNilSaved_ReturnsNil() {
        let missingCat: Cat? = userDefaults.de_object(forKey: Key.cat)
        XCTAssertNil(missingCat)
    }
    
    func testUserDefaults_IfObjectSaved_ReturnsTheSameObject() {
        let murzik = Cat(name: "Murzik", surname: nil, sex: .male, nationality: "GER",
                         birthPlace: Place(country: "Germany", city: "Jena"))
        
        userDefaults.de_set(murzik, forKey: Key.cat)
        
        guard let againMurzik: Cat = userDefaults.de_object(forKey: Key.cat) else {
            XCTFail("Failed to load Murzik")
            return
        }
        
        XCTAssertEqual(murzik, againMurzik)
    }
    
    func testUserDefaults_IfArraySaved_ReturnsTheSameArray() {
        let sonya = Cat(name: "Sonya", surname: "Kryvonis", sex: .female, nationality: "UA",
                        birthPlace: Place(country: "Ukraine", city: "Lviv"))
        let puff: Cat = Cat(name: "Puff", surname: nil, sex: .female, nationality: "US", birthPlace: nil)
        let cats = [ sonya, puff ]
        
        userDefaults.de_set(cats, forKey: Key.cat)
        guard let againCats: [Cat] = userDefaults.de_object(forKey: Key.cat) else {
            XCTFail("Failed to load cats")
            return
        }
        
        XCTAssertEqual(cats, againCats)
    }
}

// MARK: - Private

fileprivate extension UserDefaultTests {
    fileprivate struct Key {
        static let cat = "UserDefaultTests.cat"
    }
}
