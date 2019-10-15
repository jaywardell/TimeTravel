# TimeTravel

Use this package to test Swift code that is time dependent, like caching or scheduling code.

## Step 1:
In your time-dependent code, use Time.now() instead of Date()
In most cases, Time.now() returns the same thing as Date()

## Step 2:
In your test code, when you need to see what would happen if the code were run at a different time, wrap the code in one of the Time.travel() {} methods.  Any call to TIme.now() inside a time travel block will return the date passed into the block instead of the current time.


## Trivial Example Usage
'''
print("The time right now:")
print(Time.now()) // prints the current time

Time.travel(forward:60 * 60) {
    print("The time an hour from now:")
    print(Time.now()) // prints the time an hour in the future
}

'''

## Real Life Usage
Use this to test code that is time-dependent, like caching scheduling code
