mutable struct Waypoint
    x::Int
    y::Int
end

struct Coordinate
    x::Int
    y::Int
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

function rotate(wp, degrees)
    x::Int = wp.x
    y::Int = wp.y
    clockwise = degrees > 0
    quadrants = degrees ÷ 90
    newWp = Waypoint(x,y)
    if (abs(quadrants) == 1)
        newWp.x = y
        newWp.y = x
        if clockwise
            newWp.y *= -1
        else
            newWp.x *= -1
        end
    end
    if (abs(quadrants) == 2)
        newWp.x *= -1
        newWp.y *= -1
    end
    if(abs(quadrants) == 3)
        newWp.x = y
        newWp.y = x
        if clockwise
            newWp.x *= -1
        else
            newWp.y *= -1
        end
    end
    return newWp
end

# function testRotate()
#     a = Waypoint(2,1)
#     println("a90", rotate(a,90))
#     println("a180", rotate(a,180))
#     println("a270", rotate(a,270))
#     println("a-90", rotate(a,-90))
#     println("a-180", rotate(a,-180))
#     println("a-270", rotate(a,-270))
# end
# testRotate()

function moveWaypoint(currentWaypoint, action)
    x::Int = currentWaypoint.x
    y::Int = currentWaypoint.y
    newWp = Waypoint(x,y)
    if action.instruction == 'N'
        newWp.y += action.amount
    end
    if action.instruction == 'E'
        newWp.x += action.amount
    end
    if action.instruction == 'S'
        newWp.y -= action.amount
    end 
    if action.instruction == 'W'
        newWp.x -= action.amount
    end
    if action.instruction == 'L'
        degrees = -1 * action.amount
        newWp = rotate(currentWaypoint, degrees)
    end
    if action.instruction == 'R'
        degrees = action.amount
        newWp = rotate(currentWaypoint, degrees)
    end
    return newWp
end

function moveShip(currPos, wp, amount)
    x::Int = currPos.x
    y::Int = currPos.y
    newX = x + wp.x * amount
    newY = y + wp.y * amount
    newPos = Coordinate(newX, newY)
    return newPos
end

function moveWaypointWithShip(currPos, currWp)
    x::Int = currPos.x
    y::Int = currPos.y
    newWaypoint = Waypoint(x + currWp.x, y + currWp.y)
    return newWaypoint
end

function navigate(route)
    currPosition = Coordinate(0,0)
    currWaypoint = Waypoint(10,1)
    for action in route
        println(currPosition, " ", currWaypoint, " ", action)
        if action.instruction == 'F'
            currPosition = moveShip(currPosition, currWaypoint, action.amount)
        else
            currWaypoint = moveWaypoint(currWaypoint, action)
        end
    end
    manhattanDistance = abs(currPosition.x) + abs(currPosition.y)
    println("Manhattan Distance = ", manhattanDistance)
end

route = getRoute("data.txt")
navigate(route)


# function testMoveShip()
#     cp = Coordinate(0,0)
#     cw = Waypoint(10,-1)
#     newPos = moveShip(cp, cw, 2)
#     println(newPos)
# end
# testMoveShip()
