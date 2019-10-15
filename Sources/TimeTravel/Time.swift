//
//  Time.swift
//  TimeTests
//
//  Created by Joseph A. Wardell on 10/15/19.
//  Copyright © 2019 Joseph A. Wardell. All rights reserved.
//

import Foundation


/// Mainly used for testing purposes, this class allows a local way to pretend that the system is at a different time than it actually is
/// by offering a globally available now() method that returns a settable time within a given context, but returns the real system time most of the time,
public class Time {
    
//    private static var nominalTime : Date?

    private static var timeStack = [Date]()
    
    public typealias timeTravelBlock = () throws ->()
    
    /// returns the current date and time as the Time class considers it
    ///
    /// This will usually be the same as calling Date(),
    /// but could be a different time if inside a timeTravelBlock
    public static func now() -> Date {
//        return nominalTime ?? Date()
        timeStack.last ?? Date()
    }
    
    
    /// Any calls to now() within the timeTravelBlock will report now() to be the date passed in
    public static func travel(to date:Date, block:@escaping timeTravelBlock) {
//        nominalTime = date
        timeStack.append(date)
        
//        defer { nominalTime = nil }
        
        defer { timeStack.removeLast() } 
        
        do {
          try block()
        }
        catch {
//            throw error
        }
    }
    
    /// Any calls to now() within the timeTravelBlock will report now() to be  timeinterval seconds after the current Date()
    public static func travel(forward timeinterval:TimeInterval, block:@escaping timeTravelBlock) {
        
        travel(to: Date().addingTimeInterval(timeinterval), block: block)
    }

    /// Any calls to now() within the timeTravelBlock will report now() to be  timeinterval seconds before the current Date()
    public static func travel(backward timeinterval:TimeInterval, block:@escaping timeTravelBlock) {
        
        travel(to: Date().addingTimeInterval(-timeinterval), block: block)
    }

}
