mutable struct Group
    memberCount::Int
    yeses::Array{Int}
    Group() = new(0, zeros(Int,1,26))
end

char2num(c::Char) = codepoint(c) - 96

num2char(n::Int) = Char(n + 96)

function addGroupMember(line::String, group::Group)
    for yes in line
        group.yeses[char2num(yes)] += 1
    end
    group.memberCount += 1
end

function addGroupMember2(line::String, group::Group) 
    map(c -> (group.yeses[char2num(c)] += 1), collect(line))
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

function countAnyYeses2(group) 
    mapreduce(yes -> yes >= 1 ? 1 : 0, +, group.yeses)
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
                addGroupMember2(line, currentGroup)
            end
        end
    end
    return groups
end

groups = collectGroups("data.txt")

totalValidYeses = 0
for group in groups
    validGroupYeses = countAnyYeses2(group)
    global totalValidYeses += validGroupYeses
    println(group, " valid yeses =", validGroupYeses)
end
print("Total Valid Yeses = ", totalValidYeses)
