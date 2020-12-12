
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

function isOccupiedSeat(move, seatingArea)
    isOccupied = seatingArea[move[1],move[2]] == '#'
    return isOccupied
end

function adjecentOccupiedSeats(row, col, seatingArea)
    rows = size(seatingArea, 1)
    cols = size(seatingArea, 2)
    bounds = (rows, cols)
    adjSeats::Vector{Int} = []

    NW = (row-1, col-1)
    N =  (row-1, col)
    NE = (row-1, col+1)
    W =  (row,   col-1)
    E =  (row,   col+1)
    SW = (row+1, col-1)
    S =  (row+1, col)
    SE = (row+1, col+1)
    moves = [NW,N,NE,W,E,SW,S,SE]
    
    for move in moves
        if isWithin(move, bounds) && isOccupiedSeat(move, seatingArea)
            push!(adjSeats,1) 
        end
    end
    #printAdjSeats(adjSeats)
    return adjSeats
end

function printAdjSeats(a::Vector{Int})
    if length(a) > 0
        println(a[1],a[2],a[3])
        println(a[4],'*',a[5])
        println(a[6],a[7],a[8])
    else
        println("empty adjecentSeats vector")
    end
end 

function applyRulesOnSeat(row, col, seatingArea)
    adjSeats::Vector{Int} = adjecentOccupiedSeats(row, col, seatingArea)
    seatToCheck = seatingArea[row,col]
    if seatToCheck == '#' && reduce(+, adjSeats) >= 4
        return 'L'
    elseif seatToCheck == 'L' && reduce(+, adjSeats) == 0 
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

function solveProblemA()
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
       
solveProblemA()






