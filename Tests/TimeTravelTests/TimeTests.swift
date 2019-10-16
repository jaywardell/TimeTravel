//
//  TimeTestsTests.swift
//  TimeTravel
//
//  Created by Joseph A. Wardell on 10/15/19.
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

        Time.travel(forward:60) {
            print("The time a minute from now:")
            print(Time.now()) // prints the time a minute in the future
            
            Time.travel(forward:60 * 60) {
                print("The time an hour from now:")
                print(Time.now()) // prints the time an hour in the future
            }
            
            print("The time a minute from now again:")
            print(Time.now()) // prints the time a minute in the future
        }
        
        print("The time right now:")
        print(Time.now()) // prints the current time

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

    func testTimeTravelStack() {
        
        let d = Date()
        let m = d + 60
        let h = d + 60 * 60
        
        Time.travel(to:m) {
            XCTAssertEqual(Time.now(), m)
            
            Time.travel(to:h) {
                XCTAssertEqual(Time.now(), h)
            }
            // make sure that is got set back to one minute ahead
            XCTAssertEqual(Time.now(), m)
        }
        // make sure that is got set back to now
        XCTAssert(Time.now().isVeryClose(to: d))
    }

    func testTimeTravelForwardTwice() {
        
        let d = Date()
        let m = d + 60
        let handm = d + 60 * 60 + 60

        Time.travel(forward: 60) {
            XCTAssert(Time.now().isVeryClose(to:m))

            // should not move forward an hour from d, but rather an hour and one minute from d
            Time.travel(forward: 60 * 60) {
                XCTAssert(Time.now().isVeryClose(to:handm))
            }
        }
        
    }
    
}
