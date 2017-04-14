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
    
    func testJSON_IsSerialized_ToCat() {
        guard let data = data(from: "{\"name\": \"Sonya\", \"surname\": \"Kryvonis\", \"sex\": 1, \"nationality\": \"UA\", \"birthPlace\": {\"country\": \"Ukraine\", \"city\": \"Lviv\"}}") else {
            return
        }
        
        guard let actualCat: Cat = try? JSONSerialization.de_jsonObject(with: data) else {
            XCTFail("Can't parse json to a cat")
            return
        }
        
        let expectedCat = Cat(name: "Sonya", surname: "Kryvonis", sex: .female, nationality: "UA", birthPlace: Place(country: "Ukraine", city: "Lviv"))
        XCTAssertEqual(expectedCat, actualCat)
    }
    
    func testInvalidJSON_ThrowsException() {
        guard let data = data(from: "invalid JSON") else {
            return
        }
        
        do {
            let _: Cat = try JSONSerialization.de_jsonObject(with: data)
            XCTFail("It should have thrown an exception")
            
        } catch let error {
            guard let actualMessage = (error as NSError).userInfo["NSDebugDescription"] as? String else {
                XCTFail("Wrong exception type")
                return
            }
            let expectedMessage = "JSON text did not start with array or object and option to allow fragments not set."
            XCTAssertEqual(expectedMessage, actualMessage)
        }
    }

    func testWrongJSONObjectType_ThrowsException() {
        guard let data = data(from: "[]") else {
            return
        }
        
        do {
            let _: Cat = try JSONSerialization.de_jsonObject(with: data)
            XCTFail("It should have thrown an exception")
            
        } catch let error {
            guard let actualMessage = (error as NSError).userInfo["NSDebugDescription"] as? String else {
                XCTFail("Wrong exception type")
                return
            }
            let expectedMessage = "JSON object is not a dictionary."
            XCTAssertEqual(expectedMessage, actualMessage)
        }
    }

    func testWrongJSONObjectStructure_ThrowsException() {
        guard let data = data(from: "{\"name\": 0, \"surname\": \"Kryvonis\", \"sex\": 1, \"nationality\": \"UA\", \"birthPlace\": {\"country\": \"Ukraine\", \"city\": \"Lviv\"}}") else {
            return
        }
        
        do {
            let _: Cat = try JSONSerialization.de_jsonObject(with: data)
            XCTFail("It should have thrown an exception")
            
        } catch let error {
            guard let actualMessage = (error as NSError).userInfo["NSDebugDescription"] as? String else {
                XCTFail("Wrong exception type")
                return
            }
            let expectedMessage = "JSON object doesn't conform to the requested type."
            XCTAssertEqual(expectedMessage, actualMessage)
        }
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
