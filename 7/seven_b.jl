mutable struct Rule
    color::String
    containedBags::Dict{String,Int}
    Rule() = new("",Dict())
end

function parseLine(line)
    rule = Rule()
    containedBags = Dict()
    sections = split(line, "contain")
    colorsection = split(sections[1], ' ')
    rule.color = colorsection[1]*colorsection[2]
    rulesections = split(sections[2], ',')
    if rulesections[1] != " no other bags." 
        for rulesection in rulesections
            words = split(rulesection, ' ')
            amount = parse(Int,words[2])
            rulecolor = words[3]*words[4]
            containedBags[rulecolor] = amount
        end
    end
    rule.containedBags = containedBags
    return rule
end

allRules = Dict()
open("data.txt") do file
    for line in eachline(file)
        rule = parseLine(line)
        allRules[rule.color] = rule
    end
end

function countMyBags(rule)
    # println("counting in ", rule.color, " bag")
    if(length(rule.containedBags) != 0)
        myBags = 0
        for bag in rule.containedBags
            color = bag[1]
            count = bag[2]
            # println(count, " " ,color)
            myBags += count * (1 + countMyBags(allRules[color]))
        end
        return myBags
    else
        return 0
    end
end

println(countMyBags(allRules["shinygold"]))