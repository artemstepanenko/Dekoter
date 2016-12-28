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
    
    func testBob_AfterDecoding_StaysBob() {
        let bob = Person(name: "Bob")
        
        guard let data = bob.de_data, let againBob = Person.de_from(data: data) else {
            XCTFail()
            return
        }
        
        let expected = "Bob"
        let actual = againBob.name
        XCTAssertEqual(expected, actual)
    }
    
    func testMissingAge_AfterDecoding_StaysMissing() {
        let bob = Person(name: "Bob", age: nil)
        
        guard let data = bob.de_data, let againBob = Person.de_from(data: data) else {
            XCTFail()
            return
        }
        
        let expected: Int? = nil
        let actual = againBob.age
        XCTAssertEqual(expected, actual)
    }
    
    func testResidence_AfterDecoding_StaysSame() {
        let liberland = Residence(country: "Liberland")
        let bob = Person(name: "Bob", residence: liberland)
        
        guard let data = bob.de_data, let againBob = Person.de_from(data: data), let againLiberland = againBob.residence else {
            XCTFail()
            return
        }
        
        let expected = "Liberland"
        let actual = againLiberland.country
        XCTAssertEqual(expected, actual)
    }
    
    func testTeamWithoutMembers_AfterDecoding_AlsoHasNoMembers() {
        let team = Team(members: [])
        
        guard let data = team.de_data, let againTeam = Team.de_from(data: data) else {
            XCTFail()
            return
        }
        let expected: [String] = []
        let actual = againTeam.members.map { $0.name }
        XCTAssertEqual(expected, actual)
    }
    
    func testTeamWithBobAndJo_AfterDecoding_AlsoHasBobAndJo() {
        let bob = Person(name: "Bob")
        let jo = Person(name: "Jo")
        let team = Team(members: [bob, jo])
        
        guard let data = team.de_data, let againTeam = Team.de_from(data: data) else {
            XCTFail()
            return
        }
        
        let expected = [ "Bob", "Jo" ]
        let actual = againTeam.members.map { $0.name }
        XCTAssertEqual(expected, actual)
    }
}
