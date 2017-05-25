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
    
    // MARK: - Single
    
    func testJSON_IsSerialized_ToCat() {
        guard let data = data(from: "{\"name\": \"Sonya\", \"surname\": \"Kryvonis\", \"sex\": 1, \"nationality\": \"UA\", \"birthPlace\": {\"country\": \"Ukraine\", \"city\": \"Lviv\"}}") else {
            return
        }
        
        guard let actualCat: Cat = JSONSerialization.de_jsonObject(with: data) else {
            XCTFail("Can't deserialize JSON to a cat")
            return
        }
        
        let expectedCat = Cat(name: "Sonya", surname: "Kryvonis", sex: .female, nationality: "UA", birthPlace: Place(country: "Ukraine", city: "Lviv"))
        XCTAssertEqual(expectedCat, actualCat)
    }
    
    func testInvalidJSON_ReturnsNil() {
        guard let data = data(from: "invalid JSON") else {
            return
        }
        
        let actualCat: Cat? = JSONSerialization.de_jsonObject(with: data)
        XCTAssertNil(actualCat)
    }

    func testWrongJSONObjectType_ReturnsNil() {
        guard let data = data(from: "[]") else {
            return
        }
        
        
        let actualCat: Cat? = JSONSerialization.de_jsonObject(with: data)
        XCTAssertNil(actualCat)
    }

    func testWrongJSONObjectStructure_ReturnsNil() {
        guard let data = data(from: "{\"name\": 0, \"surname\": \"Kryvonis\", \"sex\": 1, \"nationality\": \"UA\", \"birthPlace\": {\"country\": \"Ukraine\", \"city\": \"Lviv\"}}") else {
            return
        }
        
        let actualCat: Cat? = JSONSerialization.de_jsonObject(with: data)
        XCTAssertNil(actualCat)
    }
    
    // MARK: - Array
    
    func testJSON_IsSerialized_ToArrayOfCats() {
        guard let data = data(from: "[{\"name\": \"Sonya\", \"surname\": \"Kryvonis\", \"sex\": 1, \"nationality\": \"UA\", \"birthPlace\": {\"country\": \"Ukraine\", \"city\": \"Lviv\"}},{\"name\": \"Charlie\", \"surname\": \"Tompson\", \"sex\": 0, \"nationality\": \"US\"}]") else {
            return
        }
        
        guard let actualCats: [Cat] = JSONSerialization.de_jsonObject(with: data) else {
            XCTFail("Can't deserialize JSON to cats")
            return
        }
        
        let expectedCats: [Cat] = [Cat(name: "Sonya", surname: "Kryvonis", sex: .female, nationality: "UA", birthPlace: Place(country: "Ukraine", city: "Lviv")),
                                   Cat(name: "Charlie", surname: "Tompson", sex: .male, nationality: "US", birthPlace: nil)]
        
        XCTAssertEqual(expectedCats, actualCats)
    }
    
    func testInvalidJSON_ReturnsNil_WhenArrayIsExpected() {
        guard let data = data(from: "invalid JSON") else {
            return
        }
        
        let actualCats: [Cat]? = JSONSerialization.de_jsonObject(with: data)
        XCTAssertNil(actualCats)
    }
    
    func testWrongJSON_OfValidAndInvalidObjects_ReturnsOnlyValidOne() {
        guard let data = data(from: "[{\"surname\": \"Kryvonis\", \"sex\": 1, \"nationality\": \"UA\", \"birthPlace\": {\"country\": \"Ukraine\", \"city\": \"Lviv\"}},{\"name\": \"Charlie\", \"surname\": \"Tompson\", \"sex\": 0, \"nationality\": \"US\"}]") else {
            return
        }
        
        guard let cats: [Cat] = JSONSerialization.de_jsonObject(with: data) else {
            XCTFail("Can't deserialize JSON to cats")
            return
        }
        
        let actualAmount = cats.count
        let expectedAmount = 1
        XCTAssertEqual(expectedAmount, actualAmount)
    }
}

// MARK: - Private

extension JSONSerializationTests {
    
    func data(from json: String) -> Data? {
        guard let data = json.data(using: .utf8) else {
            XCTFail("Can't convert the string to data")
            return nil
        }
        return data
    }
}
