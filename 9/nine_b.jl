
function parseInput(file)
    allNumbers::Vector{Int} = []
    open(file) do file
        for line in eachline(file)
            push!(allNumbers, parse(Int,line))
        end
    end
    return allNumbers
end

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

function findWeaknessA(file, preambleLength, allNumbers)
    for n in preambleLength+1:length(allNumbers)
        # println(allNumbers[n])
        if !testNumberAtIndex(allNumbers,n,preambleLength)
            println("Found weaknes in ", allNumbers[n], " at index ", n)
            return(n,allNumbers[n])
        end
    end
end

function findWeaknessB(file, preambleLength)
    allNumbers = parseInput(file)
    ixA, numberToTest = findWeaknessA(file, preambleLength, allNumbers)
    contiguousNumbers = []
    for i in 1:ixA-1
        for j in i+1:ixA-1
            view = @view allNumbers[i:j]
            sum = reduce(+, view)
            if sum == numberToTest
                println("SUCCESS! ", view, "=", sum )
                return extremeSum(view)
            end
        end
    end
end

function extremeSum(array)
    min = findmin(array)[1]
    max = findmax(array)[1]
    return min+max
end

println("ExtremeSum=",findWeaknessB("data.txt", 25))