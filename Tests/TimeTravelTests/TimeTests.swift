//
//  TimeTestsTests.swift
//  TimeTestsTests
//
//  Created by Joseph A. Wardell on 10/15/19.
//  Copyright © 2019 Joseph A. Wardell. All rights reserved.
//

import XCTest
@testable import TimeTravel

// NOTE: sometimes Date.isVeryClose will fail
// see Date+Comparisons for an explanation
// don't worry about a single failure unless the line consistently fails over multiple trials

class TimeTests: XCTestCase {
    
    // Not so much a test as a very simple usage example
    func testOutput() {
        // run this test and the following output will appear in your log

        print()
        
        print("The time right now:")
        print(Time.now()) // prints the current time

        Time.travel(forward:60 * 60) {
            print("The time an hour from now:")
            print(Time.now()) // prints the time an hour in the future
        }
        
        print()
    }

    func testTimeNowReportsCurrentDate() {
        XCTAssert(Time.now().isVeryClose(to: Date()))
    }
    
    func testTimeTravel() {
        
        Time.travel(to:Date() + 60) {
            XCTAssertFalse(Time.now().isVeryClose(to: Date()))
            XCTAssert(Time.now().isVeryClose(to: Date() + 60))
            XCTAssertFalse(Time.now().isVeryClose(to: Date() + 60.1))
            XCTAssertFalse(Time.now().isVeryClose(to: Date() + 59.9))
        }
        // make sure that is got set back
        XCTAssert(Time.now().isVeryClose(to: Date()))
        XCTAssertFalse(Time.now().isVeryClose(to: Date() + 60))

        Time.travel(to:Date() - 60) {
            XCTAssertFalse(Time.now().isVeryClose(to: Date()))
            XCTAssert(Time.now().isVeryClose(to: Date() - 60))
            XCTAssertFalse(Time.now().isVeryClose(to: Date() - 60.1))
            XCTAssertFalse(Time.now().isVeryClose(to: Date() - 59.9))
        }
        XCTAssert(Time.now().isVeryClose(to: Date()))
        XCTAssertFalse(Time.now().isVeryClose(to: Date() - 60))
    }
    
    
    func testTimeTravelForward() {
        
        Time.travel(forward:60) {
            XCTAssertFalse(Time.now().isVeryClose(to: Date()))
            XCTAssert(Time.now().isVeryClose(to: Date() + 60))
            XCTAssertFalse(Time.now().isVeryClose(to: Date() + 60.1))
            XCTAssertFalse(Time.now().isVeryClose(to: Date() + 59.9))
        }
        XCTAssert(Time.now().isVeryClose(to: Date()))
        XCTAssertFalse(Time.now().isVeryClose(to: Date() + 60))
    }
    
    func testTimeTravelBackward() {
        Time.travel(backward:60) {
            XCTAssertFalse(Time.now().isVeryClose(to: Date()))
            XCTAssert(Time.now().isVeryClose(to: Date() - 60))
            XCTAssertFalse(Time.now().isVeryClose(to: Date() - 60.1))
            XCTAssertFalse(Time.now().isVeryClose(to: Date() - 59.9))
        }
        XCTAssert(Time.now().isVeryClose(to: Date()))
        XCTAssertFalse(Time.now().isVeryClose(to: Date() - 60))
    }
    
    func testTimeTravelToCurrentDate() {
        
        // yes, it's a trivial case
        // but travelling to the current date and time
        // should work as you would expect
        Time.travel(to:Date()) {
            XCTAssert(Time.now().isVeryClose(to: Date()))
        }
        XCTAssert(Time.now().isVeryClose(to: Date()))

    }

    func testTimeTravelWorksWithThrowingFunctions() {
        
        func alwaysThrows() throws {
            enum AlwaysThrown : Error { case always }
            throw AlwaysThrown.always
        }
        
        // Time.travel() will catch any thrown errors but ignores the error
        // put any error-catching code inside your time travel block
        Time.travel(to: Date()) {
            XCTAssertThrowsError(try alwaysThrows())
        }
        
    }

}
