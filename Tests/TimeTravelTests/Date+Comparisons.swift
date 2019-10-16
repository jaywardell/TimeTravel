//
//  Date+Comparisons.swift
//  TimeTravel
//
//  Created by Joseph A. Wardell on 10/15/19.
//

import Foundation


internal extension Date {
    
    
    /// returns true if otherDate is very close to self.
    ///
    /// This method's only use case is in tests when multiple calls to Date() may be made in the same call stack.
    /// In fact, it shouldn't be relied on for anything else due to occasional false negatives
    /// only use this in test code, never in production code
    /// and never depend on it for real control flow
    /// It's only here to verify the time travel code
    func isVeryClose(to otherDate:Date) -> Bool {
        
        // TODO: a consistent way to check that two dates are nearly equivalent
        // this approach works MOST of the time, but occasionally (< 1/10000) returns false
        // when we would expect it to return true
        
        // this appears to be the closest comparison we can make before we start regularly getting
        // false positives
        // at least on a testing environment
        // on a 2014 MacBook AIR running Catalina as of 10/15/2019
        let epsilon : TimeInterval = 0.01
        
        return abs(self.distance(to: otherDate)) < epsilon
    }
}
