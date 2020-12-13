
mutable struct Location
    x::Int
    y::Int
    heading::Char
end

struct Action
    instruction::Char
    amount::Int
end
    
function getRoute(file)
    actions::Vector{Action} = []
    for line in readlines(file)
        push!(actions, Action(line[1], parse(Int,line[2:length(line)])))
    end
    #println(actions)
    return actions
end

function turnRight(direction, degrees)
    directions = ['N','E','S','W','N','E','S','W']
    dirIndex = findfirst(isequal(direction), directions)[1]
    quadrants = degrees ÷ 90
    result = directions[dirIndex + quadrants]
    println("Heading ", direction, " turning right for ", degrees, " degrees -> ", result )
    return result
end

function turnLeft(direction, degrees)
    directions = ['E','S','W','N','E','S','W','N']
    dirIndex = findlast(isequal(direction), directions)
    quadrants = degrees ÷ 90
    result = directions[dirIndex - quadrants]
    println("Heading ", direction, " turning left for ", degrees, " degrees -> ", result )
    return result
end

function newLocation(currentLocation, newDirection, amountToMove, changeDirection)

    newLocation = currentLocation
    if newDirection == 'N'
        newLocation.y += amountToMove
    end
    if newDirection == 'W'
        newLocation.x -= amountToMove
    end
    if newDirection == 'S'
        newLocation.y -= amountToMove
    end
    if newDirection == 'E'
        newLocation.x += amountToMove
    end

    newLocation.heading = changeDirection ? newDirection : currentLocation.heading
    #println("newLocation ", newLocation)
    return newLocation
end

function move(currentLocation, action)
    println(action)
    currentDirection = currentLocation.heading
    directionToMove = '_'
    changeDirecton = false
    if action.instruction == 'F'
        directionToMove = currentDirection
        amountToMove = action.amount
        changeDirection = false
    end
    if findfirst(action.instruction, "NWES") != nothing
        directionToMove = action.instruction
        amountToMove = action.amount
        changeDirection = false
    end
    if action.instruction == 'R'
        directionToMove = turnRight(currentDirection, action.amount)
        amountToMove = 0
        changeDirection = true
    end
    if action.instruction == 'L'
        directionToMove = turnLeft(currentDirection, action.amount)
        amountToMove = 0
        changeDirection = true
    end
    println("Instruction=", action.instruction, " directionToMove=", directionToMove, " changeDir=", changeDirection)
    println("Moving ", amountToMove, " to the ", directionToMove)
    return (directionToMove, amountToMove, changeDirection)
end


function navigate(route)
    startingPoint = Location(0,0,'E')
    currentLocation = Location(0,0,'E')
    for action in route
        println(currentLocation)
        directionToMove, amountToMove, changeDirection = move(currentLocation, action)
        currentLocation = newLocation(currentLocation, directionToMove, amountToMove, changeDirection)
        println("")
    end
    traveledNS = abs(currentLocation.y - startingPoint.y)
    traveledEW = abs(currentLocation.x - startingPoint.x)
    manhattanDistance = traveledNS + traveledEW
    println("Manhattan Distance = ", manhattanDistance)
end

route = getRoute("data.txt")
navigate(route)


# function testNewLocation()
#     currentLocation = Location(0,0,'E')
#     currentLocation = newLocation(currentLocation, 'N', 2)
#     println("")
#     currentLocation = newLocation(currentLocation, 'E', 2)
#     println("")
#     currentLocation = newLocation(currentLocation, 'S', 2)
#     println("")
#     currentLocation = newLocation(currentLocation, 'W', 2)
#     println("")
# end
# testNewLocation()


# function testLR()
#     println("N")
#     println("turnLeft('N')=", turnLeft('N') )
#     println("turnRight('N')=", turnRight('N') )
#     println("")
#     println("E")
#     println("turnLeft('E')=", turnLeft('E') )
#     println("turnRight('E')=", turnRight('E') )
#     println("")
#     println("S")
#     println("turnLeft('S')=", turnLeft('S') )
#     println("turnRight('S')=", turnRight('S') )
#     println("")
#     println("W")
#     println("turnLeft('W')=", turnLeft('W') )
#     println("turnRight('W')=", turnRight('W') )
#     println("")

# end
# testLR()
