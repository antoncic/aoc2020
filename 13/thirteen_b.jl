

function getModuloList(inputfile)
    lines = readlines(inputfile)
    idsStirng = lines[2]
    ids::Array{Int} = []
    for idSubString in split(idsStirng, ',') 
        idString = String(idSubString)
        if idString != "x"
            push!(ids, parse(Int, idString))
        else
            push!(ids, 0)
        end
    end
    # println(ids)
    return ids
end

function printRow(t, moduloList)
    row = []
    for i in 1:length(moduloList)
        value = (t % moduloList[i] > 0) ? 0 : 1
        push!(row, value)
    end
    # println(row)
end

function found(timestamp, moduloList)
    t = timestamp 
    result = true
    for i in 1:length(moduloList)
        # print(t, " ")
        if (moduloList[i] > 0) 
            if t % moduloList[i] == 0
                result = result && true
                # print(" D")
            else
                result = result && false
                return false
            end
        else
            # print(" never mind")
        end
        # println()
        t += 1
    end
    # println(result)
    return result
end

function findFirst(inputFile)
    moduloList = getModuloList(inputFile)
    println(moduloList)
    firstMod = moduloList[1]
    t = firstMod
    isFound = false
    while !isFound 
        if found(t, moduloList)
            break
        else
            t += firstMod
        end
    end
    println(t)
end

findFirst("data_test.txt")