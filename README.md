# aoc2020
Advent of Code 2020, in Julia lang this year 

## Updating Julia to new version on Mac
Just download and run the latest binary from https://julialang.org/downloads/ and it will ask if you want to replace older version (if such exists)

## Package management
Pkg package manager is used. It is centered around ***environments***: 
>Independent sets of packages that can be local to an indivdual project or shared and selected by name.
>
>The exact set of packages and versions in an environment is captured in a manifest file which can be checked into a
project repository and tracked in version control. 

- Project
- Environment
    - Defines which packages that are available to a piece of code
- Module
- Package
    - A module that can be refered to in a package registry with a globally unique version (UUID)

*Package mangaement will need more reading*

## Nice, cosy feeling
Julia is **one-based**! Why on earth did we do zero-based in the other languaes?

## Classes are called Composite Types
Just create a **struct** or a **mutable struct**. A struct is imutable, hence the mutable struct.

## Variable Scope
Make sure to do anything usefull inside a function. Do not use global variables.

## Regexp
regexp are denoted by 
```
r"<some regexp>"
```

