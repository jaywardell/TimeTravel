//
//  Date+ComparisonTests.swift
//  TimeTravel
//
//  Created by Joseph A. Wardell on 10/15/19.
//

import XCTest

class Date_ComparisonTests: XCTestCase {

    // NOTE: these tests will occasionally catch a failure
    // due to the way Swift maintains Dates internally
    // this is not a problem for our purposes
    // as we just need a way to verify that the time travel code works
    func testEquivalentDates() {
        
        // in testing this, we got some inconsistentcy,
        // so do multiple calls in succession to ensure
        // that the method works consistently
        for _ in 0..<100 {

            // make sure that a functionally exact match is a match
            XCTAssert(Date().isVeryClose(to:Date()))
            
            // but also ensure that a close match always works
            XCTAssert(Date().isVeryClose(to: Date() + 0.0000000001))
            XCTAssert(Date().isVeryClose(to: Date() - 0.0000000001))

            // but that a difference of a miillisecond doesn't
            XCTAssertFalse(Date().isVeryClose(to: Date() + 0.1))
            XCTAssertFalse(Date().isVeryClose(to: Date() - 0.1))
        }
    }
}
