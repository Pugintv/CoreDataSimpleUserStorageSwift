//
//  PasswordValidatorTests.swift
//  CoreDataSimpleUserStorageSwiftTests
//
//  Created by Victor Rosas on 10/8/18.
//  Copyright © 2018 Victor Rosas. All rights reserved.
//

import XCTest
@testable import CoreDataSimpleUserStorageSwift

class PasswordValidatorTests: XCTestCase {
    
    let validator = PasswordValidator()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasNumber(){
       let hasNumber = validator.hasNumbers(textInput: "123")
        XCTAssert(hasNumber)
    }
    
    func testHasNoNumber(){
        let hasNumber = validator.hasNumbers(textInput: "abc")
        XCTAssertFalse(hasNumber)
    }
    
    func testHasLetter(){
        let hasLetter = validator.hasLetters(textInput: "abc")
        XCTAssert(hasLetter)
    }
    
    func testHasNoLetter(){
        let hasLetter = validator.hasLetters(textInput: "123")
        XCTAssertFalse(hasLetter)
    }
    
    func testIsInRange(){
        let isInRange = validator.isInRange(topRange: 12, bottomRange: 5, textInput: "abcdefg")
        XCTAssert(isInRange)
    }
    
    func testIsNotInRange(){//If requirement asks for alert for each case then short or long methods will be established
        let isInRange = validator.isInRange(topRange: 12, bottomRange: 5, textInput: "a")
        XCTAssertFalse(isInRange)
    }
    
    func testHasRepeatingSeq(){
        let hasRepeating = validator.hasSequenceRepetition(textInput: "abab")
        print(hasRepeating)
        XCTAssert(hasRepeating)
    }
    
    func testHasNoRepeatingSequence(){
        let hasRepeating = validator.hasSequenceRepetition(textInput: "abce")
        print(hasRepeating)
        XCTAssertFalse(hasRepeating)
    }
    
    func testHasValidChars(){
        let hasValidChars = validator.containsInvalidChars(textInput: "abc123")
        XCTAssertFalse(hasValidChars)
    }
    
    func testHasInvalidChars(){
        let hasInvalidChars = validator.containsInvalidChars(textInput: "@_AB2%$")
        XCTAssert(hasInvalidChars)
    }
    
    func testIsValid(){
        let isValid = validator.isValid(textInput: "abc123")
        XCTAssert(isValid)
    }
    
    func testIsInvalid(){
        let isValid = validator.isValid(textInput: "123@s")
        XCTAssertFalse(isValid)
    }
    

}
