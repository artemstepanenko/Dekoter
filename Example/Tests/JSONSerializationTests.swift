//
//  JSONSerializationTests.swift
//  Dekoter
//
//  Created by Artem Stepanenko on 14/04/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Dekoter

class JSONSerializationTests: XCTestCase {
    
    func testJSON_IsSerivalized_ToCat() {
        guard let data = data(from: "{\"name\": \"Sonya\", \"surname\": \"Kryvonis\", \"sex\": 1, \"nationality\": \"UA\", \"birthPlace\": {\"country\": \"Ukraine\", \"city\": \"Lviv\"}}") else {
            XCTFail("Can't convert the string to data")
            return
        }
        
        guard let actualCat: Cat = JSONSerialization.de_jsonObject(with: data) else {
            XCTFail("Can't parse json to a cat")
            return
        }
        
        let expectedCat = Cat(name: "Sonya", surname: "Kryvonis", sex: .female, nationality: "UA", birthPlace: Place(country: "Ukraine", city: "Lviv"))
        XCTAssertEqual(expectedCat, actualCat)
    }

}

// MARK: - Private

extension JSONSerializationTests {
    
    func data(from json: String) -> Data? {
        return json.data(using: .utf8)
    }
}
