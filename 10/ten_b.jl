using DataStructures

function getAllAdaptersInBag(input)
    allAdapters::SortedDict{Int, Vector{Int}} = SortedDict{Int, Vector{Int}}()
    for line in readlines(input)
        allAdapters[parse(Int,line)] = []
    end
    return allAdapters
end

function addSocketAndDevice(allAdaptersInBag)
    allAdapters = allAdaptersInBag
    allAdapters[0] = []
    highestRating = findmax(collect(keys(allAdapters)))[1]
    allAdapters[highestRating + 3] = []
    return allAdapters
end


function createTree(allAdapters)
    allkeys = sort(collect(keys(allAdapters)))
    for i in length(allkeys):-1:1
        key = allkeys[i]
        kids = allAdapters[key]
        j = i-1
        while (j >= 1) && (key - allkeys[j] <= 3)
            push!(kids, allkeys[j]) 
            j -= 1
        end
        #println(key, " ", kids)
    end
    return allAdapters, last(allkeys)
end

function permutationsForRange(range)
    diff = range[1] - range[2]
    diff == 1 && return 1
    diff == 2 && return 2
    diff == 3 && return 4
    diff == 4 && return 7
    diff == 5 && return 13
    diff > 5 && return error("Haven't figured it out yet...")
end

function findNextConsecutiveRangeAndCalcuatePermutations(startIndex, allKeys, allAdapters)
    firstAdapterWithKids = 0
    lastAdapterWithKids = 0
    nextStart = startIndex
    permutations = 1
    #println("startIndex =" , startIndex)
    for i in startIndex:-1:1
        rating = allKeys[i]
        kids = allAdapters[rating]
        println("i, adapter:", i, " ", rating, " ", kids)

        if length(kids) > 1 
            if firstAdapterWithKids == 0 # found first
                firstAdapterWithKids = rating
                nextStart -= 1
                #println("found first")
            else # found possibly last
                nextStart -= 1
                #println("found possibly last")
            end
        else 
            if (firstAdapterWithKids == 0) # thank you, next
                nextStart -= 1
                #println("Thank you, next")
                break
            else # previus was last
                lastAdapterWithKids = allKeys[i+1]
                println("lastawk=", lastAdapterWithKids)
                max = firstAdapterWithKids
                lastKids = allAdapters[lastAdapterWithKids]
                println("lastkids=", lastKids)
                min = findmin(lastKids)[1]
                range = (max,min)
                permutations = permutationsForRange(range)
                println(range, " ", permutations)
                nextStart -= 1
                break
            end
        end
    end
    #println("permutations=",permutations )
    return nextStart, permutations
end


    

function solveProblemB()
    allAdaptersInBag = getAllAdaptersInBag("data.txt")
    allAdapters = addSocketAndDevice(allAdaptersInBag)
    adapterTree, rootRating = createTree(allAdapters)
    
    allKeys = sort(collect(keys(allAdapters)))
    totalPermutations = 1
    index = findmax(allKeys)[2]

    while index > 1
        nextIndex, permutations = findNextConsecutiveRangeAndCalcuatePermutations(index, allKeys, allAdapters)
        totalPermutations *= permutations
        index = nextIndex
    end
    println("Arrangements=", totalPermutations)
end

solveProblemB()
