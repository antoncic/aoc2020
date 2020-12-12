
function getSeatingArea(file)
    lines = map(collect, readlines(file))
    rows = length(lines)
    cols = length(lines[1])
    seatingArea::Matrix{Char} = Matrix{Char}(undef, rows, cols)
    for i in 1:rows
        line = lines[i]
        for j in 1:cols
            seat = line[j]
            seatingArea[i,j] = seat
        end
    end
    return seatingArea
end

function isWithin(move, bounds)
    rows = bounds[1]
    cols = bounds[2]
    within = (1 <= move[1] <= rows) && (1 <= move[2] <= cols)
    #println(move, " ", bounds, " ", within)
    return within
end

function isSeat(move, seatingArea)
    moveValue = seatingArea[move[1],move[2]] 
    isSeat = moveValue == '#' || moveValue == 'L'
    return isSeat
end

function findVisibleOccupiedSeats(row, col, seatingArea)
    rows = size(seatingArea, 1)
    cols = size(seatingArea, 2)
    bounds = (rows, cols)
    visibleSeats::Vector{Int} = []

    NW = (-1, -1)
    N =  (-1, 0)
    NE = (-1, 1)
    W =  (0, -1)
    E =  (0, 1)
    SW = (1, -1)
    S =  (1, 0)
    SE = (1, 1)
    directions = [NW,N,NE,W,E,SW,S,SE]
    
    for direction in directions
        if firstSeatVsibleInDirectionIsOccupied(row, col, direction, bounds, seatingArea)
            push!(visibleSeats,1)
        end
    end
    return visibleSeats
end

function firstSeatVsibleInDirectionIsOccupied(row, col, direction, bounds, seatingArea)
    rows = size(seatingArea, 1)
    cols = size(seatingArea, 2)
    #println(col,row)
    move = (row + direction[1], col + direction[2])
    #println(move)
    
    while isWithin(move,bounds)
        moveValue = seatingArea[move[1],move[2]]
        if moveValue == '.'
            move = (move[1] + direction[1], move[2] + direction[2])
        end
        if moveValue == '#'
            return true
        end
        if moveValue == 'L'
            return false
        end
        #println(move)
    end
    return false
end

function applyRulesOnSeat(row, col, seatingArea)
    visibleSeats::Vector{Int} = findVisibleOccupiedSeats(row, col, seatingArea)
    seatToCheck = seatingArea[row,col]
    if seatToCheck == '#' && reduce(+, visibleSeats) >= 5
        return 'L'
    elseif seatToCheck == 'L' && reduce(+, visibleSeats) == 0 
        return '#'
    else
        return seatToCheck
    end
end

function countOccuppied(seatingArea)
    rows = size(seatingArea, 1)
    cols = size(seatingArea, 2)
    occurrencies = 0
    for i in 1:rows
        for j in 1:cols
            if seatingArea[i,j] == '#'
                occurrencies += 1
            end
        end
    end
    return occurrencies
end

function runRound(seatingArea)
    newSA = copy(seatingArea)
    rows = size(seatingArea, 1)
    cols = size(seatingArea, 2)
    for i in 1:rows
        for j in 1:cols
            newSA[i,j] = applyRulesOnSeat(i, j, seatingArea)
        end
    end
    #printSA(newSA)
    return newSA
end

function printSA(seatingArea)
    rows = size(seatingArea, 1)
    cols = size(seatingArea, 2)
    for i in 1:rows
        for j in 1:cols
            print(seatingArea[i,j])
        end
        print("\n")
    end
    println("")
end

function solveProblem()
    seatingArea = getSeatingArea("data.txt")
    #printSA(seatingArea)
    newSeatingArea = runRound(seatingArea) 
    while(seatingArea != newSeatingArea)
        seatingArea = newSeatingArea
        newSeatingArea = runRound(newSeatingArea) 
    end
    occupiedSeats = countOccuppied(newSeatingArea)
    println("succes, result=", occupiedSeats)
end
       
solveProblem()






