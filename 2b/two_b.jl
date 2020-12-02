struct Policy
    letter:: String
    min:: Int
    max:: Int
end

function parseLine(line)
    parts = split(line, ' ')
    range = parts[1]
    letter = String(SubString(parts[2], 1, 1))
    pwd = string(parts[3])

    dash_ix = findfirst('-', line)
    min = SubString(range, 1, dash_ix - 1)
    max = SubString(range, dash_ix + 1)
    policy = Policy(letter, parse(Int, min), parse(Int, max))

    return policy, pwd
end

function validPassword(policy::Policy,pwd::String)
    foundLetter = 0
    for i in 1:length(pwd)
        if (pwd[i] == policy.letter[1])
            foundLetter += 1
        end
    end
    return policy.min <= foundLetter && policy.max >= foundLetter
end

function newValidationPolicy(policy::Policy,pwd::String)
    exactlyOne = 0
    if pwd[policy.min] == policy.letter[1] 
        exactlyOne += 1
    end
    if pwd[policy.max] == policy.letter[1] 
        exactlyOne += 1
    end
    return exactlyOne == 1
end

open("data.txt") do file
    validPasswords = 0
    for line in eachline(file)
        policy, pwd = parseLine(line)
        if newValidationPolicy(policy, pwd)
            validPasswords += 1
        end
    end
    println("Answer:" , validPasswords)
end

