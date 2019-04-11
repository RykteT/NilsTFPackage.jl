# NilsTFPackage.jl

Type to keep track of the biggest float used in a sequence of instructions.

[![Build Status](https://travis-ci.org/RykteT/NilsTFPackage.jl.svg?branch=master)](https://travis-ci.org/RykteT/NilsTFPackage.jl)
[![codecov](https://codecov.io/gh/RykteT/NilsTFPackage.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/RykteT/NilsTFPackage.jl)

### Usage
The TrackingFloat could be used to keep track of the largest value seen by the
struct. Using a TrackingFloat inside a function (as an alternative to a
Float) would return the correct answer as well as the biggest float seen/handled
throughout the function.

### Example

    v1 = TrackingFloat(1) #Stores 1 as the value and 0 as the max
    v2 = v1 + 2           #v2 == TrackingFloat(3, 2) since 2 is the biggest number it has encountered
    v3 = -4v2             #v3 == TrackingFloat(-12, 4) since 4 is the biggest factor in this number.

### Instructions
The Package includes the struct TrackingFloat as well as functions handling
basic instructions for the TrackingFloat.  
  
Among others:
* Addition/subtraction : +/- 
* Multiplication       : *
* Division             : /
* Square roots
* Get maximum value and maximum memory.

