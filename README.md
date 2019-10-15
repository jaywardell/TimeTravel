# TimeTravel

Use this package to test Swift code that is time dependent, like caching or scheduling code.

## Usage

### Step 1:
// TODO: explain importing into XCode project

### Step 2:
Import TimeTravel into any Swift file that contains time-dependent production code

    import TimeTravel
    
### Step 3:
In your time-dependent production code, use `Time.now()` instead of `Date()`
In most cases, Time.now() returns the same thing as Date()

### Step 4:
In your test code, when you need to see what would happen if the code were run at a different time, wrap the code in one of the `Time.travel()` methods.  Any call to `Time.now()` inside a time travel block will return the date and time passed into the block instead of the current date and time.

TimeTravel maintains a stack of calls to `Time.travel()`, so if you nest one call within another, you can be assured of the proper behavior.

NOTE: `Time.travel()` will catch errors and not rethrow them, so you should perform any error catchign code within the time travel block.



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

// TODO: Publish this
