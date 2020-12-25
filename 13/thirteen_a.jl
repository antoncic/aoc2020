function miuntesTillNext(a_now::Int, busId::Int)
    #println(a_now, ", " , busId)
    timeSinceLast = a_now % busId
    #println("timeSinceLast=", timeSinceLast)
    a_lastDep = (a_now ÷ busId) * busId
    #println("a_lastDep=", a_lastDep)
    a_nextDep = a_lastDep + busId
    #println("a_nextDep=", a_nextDep)
    tillNext = a_nextDep - a_now
    #println("tillNext=", tillNext)
    return tillNext
end

function findEarliest(inputfile)
    lines = readlines(inputfile)
    now::Int = parse(Int,lines[1])
    idsStirng = lines[2]
    ids:: Vector{Int} = []
    for idSubString in split(idsStirng, ',') 
        idString = String(idSubString)
        if idString != "x"
            push!(ids, parse(Int, idString))
        end
    end
    candidates = Dict()
    for id in ids
        candidates[id] = miuntesTillNext(now, id)
    end
    min = findmin(candidates)
    println(min, " " , min[1]*min[2])
end

findEarliest("data.txt")
