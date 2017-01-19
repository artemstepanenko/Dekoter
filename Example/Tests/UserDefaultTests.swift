//
//  UserDefaultTests.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 16/01/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Dekoter

class UserDefaultTests: XCTestCase {
    
    func testMurzik_AfterExtractingFromUserDefaults_StaysMurzik() {
        let murzik = Cat(name: "Murzik", surname: nil, sex: .male, nationality: "GER", birthPlace: nil)
        let userDefaults = UserDefaults()
        
        userDefaults.de_set(murzik, forKey: "cat")
        
        guard let againMurzik: Cat = userDefaults.de_object(forKey: "cat") else {
            XCTFail()
            return
        }
        let actual = againMurzik.name
        let expected = "Murzik"
        
        XCTAssertEqual(actual, expected)
    }

}
