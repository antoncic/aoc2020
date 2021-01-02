function parseMask(line)
    # result = "XXXXXXXXXXXXXXXXXXXXXXXXXXXX" * String(split(line,"mask = ")[2])
    result = "0000000000000000000000000000" * String(split(line,"mask = ")[2])
    return result
end

struct Instruction
    pos::Int
    value::Int
end

function parseInstruction(line)
    insideSquareBrackets = r"\[([^()]*)\]"
    pos = match(insideSquareBrackets, line).captures[1]
    value = split(line, " = ")[2]
    result = Instruction(parse(Int, pos), parse(Int, value))
    return result
end

function applyCondition(x::Tuple{Char,Char})
    m = x[1]
    c = x[2]
    if m == 'X'
        return 'X'
    elseif m == '0'
        return c
    elseif m == '1'
        return '1'
    else
        throw("wrong character for mask")
    end
end

function applyMask(mask::String, pos::Int)
    println(mask)
    posBstr = bitstring(pos)
    println(posBstr)
    c = zip(mask, posBstr)
    resultStr = String(map(x -> applyCondition(x), c))
    #result = parse(Int, resultStr, base=2)
    return resultStr
end

function applyPermutation(floatingPos::String, permutation)
    result = collect(Char, floatingPos)
    for tuple in permutation
        index = tuple[1]
        value = tuple[2]
        result[index] = value
    end
    return String(result)
end

function execute(mask, instruction, memory)
    floatingPos = applyMask(mask, instruction.pos)
    xs = findall(x -> x == 'X', floatingPos)
    permutations = (2^(length(xs)))
    println(permutations)
    for i in 0:permutations-1
        bits = string(i, base = 2, pad = length(xs))
        permutation = zip(xs, bits)
        newPosStr = applyPermutation(floatingPos, permutation)
        # println(newPosStr)
        newPos = parse(Int, newPosStr, base = 2)
        memory[newPos] = instruction.value
    end
end

function runProgram(inputFile)
    memory = Dict()
    mask = ""
    for line in readlines(inputFile)
        if startswith(line,"mask")
            mask = parseMask(line)
        else
            instruction = parseInstruction(line)
            execute(mask, instruction, memory)
        end
    end
    println(reduce(+,values(memory)))
end

runProgram("data.txt")
# memory = zeros(Int, 100000)
# mask = parseMask("mask = X00XX111000XX011110110X1X0101000101X")
# instruction = Instruction(0,0)
# execute(mask, instruction, memory)