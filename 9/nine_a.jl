
function parseInput(file)
    allNumbers::Vector{Int} = []
    open(file) do file
        for line in eachline(file)
            push!(allNumbers, parse(Int,line))
        end
    end
    return allNumbers
end

# function findPreamble(numbers, length)
#     result::Vector{Int} = []
#     for i in 1:length
#         push!(result, numbers[i])
#     end
#     return result
# end

function testNumberAtIndex(allNumbers, numberIndex, preambleLength)
    result = 0
    numberToTest = allNumbers[numberIndex]
    lastIx = numberIndex-1
    startIx = numberIndex-preambleLength
    for i in startIx:1:lastIx
        for j in startIx:1:lastIx
            a = allNumbers[i]
            b = allNumbers[j]
            # println("a+b=", a+b)
            if a != b && a + b == numberToTest
                result += 1 
            end
        end
    end
    return result > 0
end

function findWeakness(file, preambleLength)
    allNumbers = parseInput(file)
    for n in preambleLength+1:length(allNumbers)
        # println(allNumbers[n])
        if !testNumberAtIndex(allNumbers,n,preambleLength)
            println("Found weaknes in ", allNumbers[n], " at index ", n)
        end
    end
end
    
findWeakness("data.txt", 25)