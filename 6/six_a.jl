mutable struct Group
    memberCount::Int
    yeses::Array{Int}
    Group() = new(0, zeros(Int,1,26))
end

function char2num(c::Char)
    return codepoint(c) - 96
end

function num2char(n::Int)
    return Char(n + 96)
end

function addGroupMember(line::String, group::Group)
    for yes in line
        group.yeses[char2num(yes)] += 1
    end
    group.memberCount += 1
end

function countAnyYeses(group)
    result = 0
    for yes in group.yeses
        if yes >= 1
            result += 1
        end
    end
    return result
end

function countAllYeses(group)
    result = 0
    for yes in group.yeses
        if yes == group.memberCount
            result += 1
        end
    end
    return result
end

function collectGroups(fileName)
    groups = []
    groupCounter = 1
    currentGroup = Group()
    open(fileName) do file
        for line in eachline(file)
            if length(line) == 0 
                push!(groups, currentGroup)
                currentGroup = Group()
                groupCounter += 1
            else
                addGroupMember(line, currentGroup)
            end
        end
    end
    return groups
end

groups = collectGroups("data.txt")

totalValidYeses = 0
for group in groups
    validGroupYeses = countAllYeses(group)
    global totalValidYeses += validGroupYeses
    println(group, " valid yeses =", validGroupYeses)
end
print("Total Valid Yeses = ", totalValidYeses)