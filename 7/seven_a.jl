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

# allRules = Dict{String,Rule}()
allRules = []
open("data.txt") do file
    for line in eachline(file)
        push!(allRules, parseLine(line))
    end
end

function countGoldenBags()
    goldRelatedColors = Set()
    currentColors = ["shinygold"]
    while length(currentColors) != 0
        newColors::Array{String} = []
        for currColor in currentColors
            for rule in allRules
                if haskey(rule.containedBags, currColor)
                    push!(newColors, rule.color)
                end
            end
        end
        println(newColors)
        for newColor in newColors
            push!(goldRelatedColors, newColor)
        end
        currentColors = newColors
    end
    println(length(goldRelatedColors))
end

countGoldenBags()