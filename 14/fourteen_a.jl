function parseMask(line)
    result = "XXXXXXXXXXXXXXXXXXXXXXXXXXXX" * String(split(line,"mask = ")[2])
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
        return c
    elseif m == '0'
        return '0'
    elseif m == '1'
        return '1'
    else
        throw("wrong character for mask")
    end
end

function applyMask(mask::String, value::Int)
    valueBstr = bitstring(value)
    c = zip(mask, valueBstr)
    resultStr = String(map(x -> applyCondition(x), c))
    result = parse(Int, resultStr, base=2)
    return result
end

function execute(mask, instruction, memory)
    newValue = applyMask(mask, instruction.value)
    memory[instruction.pos] = newValue
end

function runProgram(inputFile)
    memory = zeros(Int, 100000)
    mask = ""
    for line in readlines(inputFile)
        if startswith(line,"mask")
            mask = parseMask(line)
        else
            instruction = parseInstruction(line)
            execute(mask, instruction, memory)
        end
    end
    println(reduce(+,memory))
end

runProgram("data.txt")