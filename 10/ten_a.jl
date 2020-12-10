function getAllAdaptersInBag(input)
    allAdapters::Vector{Int} = []
    for line in readlines(input)
        push!(allAdapters, parse(Int,line))
    end
    return sort(allAdapters)
end

function calculateAllOutlets(allAdapters)
    plane::Vector{Int} = [0]
    device::Vector{Int} = [findmax(allAdapters)[1] + 3]
    return vcat(plane,allAdapters,device)
end

function solveProblemA()
    allAdapters = getAllAdaptersInBag("data.txt")
    allOutlets = calculateAllOutlets(allAdapters)
    diffs::Vector{Int} = [0,0,0]
    for i in 2:length(allOutlets)
        diff = allOutlets[i] - allOutlets[i-1]
        diffs[diff] +=1
    end
    println(diffs[1]*diffs[3])
end

solveProblemA()

