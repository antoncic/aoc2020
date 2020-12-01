# aoc2020
Advent of Code 2020, in Julia lang this year 

## Updating Julia to new version on Mac
Just download and run the latest binary from https://julialang.org/downloads/ and it will ask if you want to replace older version (if such exists)

## Package management
Pkg package manager is usesd. It is centered around ***environments***: 
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

