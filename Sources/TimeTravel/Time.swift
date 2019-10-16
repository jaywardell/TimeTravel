//
//  Time.swift
//  TimeTravel
//
//  Created by Joseph A. Wardell on 10/15/19.
//

import Foundation


/// Mainly used for testing purposes, this class allows a local way to pretend that the system is at a different time than it actually is
/// by offering a globally available now() method that returns a settable time within a given context, but returns the real system time most of the time,
public class Time {
    
    private static var timeStack = [Date]()
    
    public typealias timeTravelBlock = () throws ->()
    
    /// returns what the Time class considers  the current date and time
    ///
    /// This will usually be the same as calling Date(),
    /// but could be a different time if it's called inside a timeTravelBlock
    public static func now() -> Date {
        timeStack.last ?? Date()
    }
    
    
    /// Any calls to now() within the timeTravelBlock will report now() to be the date passed in
    ///
    /// Note that this method catches errors and doesn't rethrow them, so you should put any error handling code within the block rather than outside it
    public static func travel(to date:Date, block:@escaping timeTravelBlock) {
        timeStack.append(date)
        defer { timeStack.removeLast() }
        
        do {
          try block()
        }
        catch {
            // noop, let the caller handle any errors in the timeTravelBlock
        }
    }
    
    /// Any calls to now() within the timeTravelBlock will report now() to be timeinterval seconds after the current Time.now()
    public static func travel(forward timeinterval:TimeInterval, block:@escaping timeTravelBlock) {
        
        travel(to: Time.now().addingTimeInterval(timeinterval), block: block)
    }

    /// Any calls to now() within the timeTravelBlock will report now() to be timeinterval seconds before the current Time.now()
    public static func travel(backward timeinterval:TimeInterval, block:@escaping timeTravelBlock) {
        
        travel(to: Time.now().addingTimeInterval(-timeinterval), block: block)
    }
}
