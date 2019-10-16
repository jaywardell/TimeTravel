# TimeTravel

Use this package to test Swift code that is time-dependent, like caching or scheduling code.

## Usage

### Step 1:

Import TimeTravel into your project.

TimeTravel is available as a Swift Package at https://github.com/jaywardell/TimeTravel.  
You can downlaod it or import it in XCode using `File->Swift Packages->Add Package Dependency…`

### Step 2:

Import TimeTravel into any Swift file that contains time-dependent production code

    import TimeTravel
    
### Step 3:

In your time-dependent production code, use `Time.now()` instead of `Date()`
In most cases, `Time.now()` returns the same thing as `Date()`

### Step 4:

In your test code, when you need to see what would happen if the code were run at a different time, wrap the code in one of the `Time.travel()` methods.  Any call to `Time.now()` inside a time travel block will return the date and time passed into the block instead of the current date and time.

The available `Time.travel()` methods are:

    /// Any calls to now() within the timeTravelBlock will report now() to be the date passed in
    public static func travel(to date:Date, block:@escaping timeTravelBlock)

    /// Any calls to now() within the timeTravelBlock will report now() to be timeinterval seconds after the current Time.now()
    public static func travel(forward timeinterval:TimeInterval, block:@escaping timeTravelBlock)

    /// Any calls to now() within the timeTravelBlock will report now() to be timeinterval seconds before the current Time.now()
    public static func travel(backward timeinterval:TimeInterval, block:@escaping timeTravelBlock)

TimeTravel maintains a stack of calls to `Time.travel()`, so if you nest one call within another, you can be assured of the proper behavior.

NOTE: `Time.travel()` will catch errors and not rethrow them, so you should perform any error handling code within the time travel block.


## Trivial Example Usage

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

will output

    The time right now:
    2019-10-15 16:35:45 +0000
    The time a minute from now:
    2019-10-15 16:36:45 +0000
    The time an hour from now:
    2019-10-15 17:35:45 +0000
    The time a minute from now again:
    2019-10-15 16:36:45 +0000
    The time right now:
    2019-10-15 16:35:45 +0000

... or something similar at the time that you run it...

## Real Life Usage
Use this to test code that is time-dependent, like caching or scheduling code

// TODO: a simple example of a timed cache and some test cases

## Requirements
TimeTravel has only been tested against Swift 5.1 and XCode 11.  It may work with some previous versions of swift.

## License (of sorts)
TimeTravel is free to use or modify in any way you see fit.  If you have an idea for an improvement, please submit a pull request.
