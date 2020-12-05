struct BordingPass
    row::Int
    seat::Int
    id::Int
end

function createBinaryString(string, zero::Char, one::Char)
    bstring = ""
    for c in string
        if c == zero
            bstring = bstring*"0"
        else
            bstring = bstring*"1"
        end
    end
    return bstring 
end

function rowNumber(rowString)
    binaryRow = createBinaryString(rowString, 'F', 'B')
    return parse(Int, binaryRow, base=2)
end

function seatNumber(seatString)
    binarySeat = createBinaryString(seatString, 'L', 'R')
    return parse(Int, binarySeat, base=2)
end

function createBordingPass(line)
    rowString::String = SubString(line, 1:7)
    seatString::String = SubString(line, 8:10)
    row = rowNumber(rowString)
    seat = seatNumber(seatString)
    id = row * 8 + seat
    return BordingPass(row,seat,id)
end

open("data.txt") do file
    validIds = []
    for line in eachline(file)
        bordingPass = createBordingPass(line)
        push!(validIds, bordingPass.id)
    end
    validIds = sort(validIds)

    lastId = validIds[1]
    for id in validIds
        if((id - lastId) > 1)
            myId = id-1
            println("lastId=", lastId, " id=", id, " -> myId=" , myId)
            break
        else
            lastId = id
        end
    end
end