mutable struct Instruction
    op::String
    arg::Int 
end

function instructionParser(line)
    parts = split(line, " ")
    op = parts[1]
    arg = parse(Int, parts[2])
    return Instruction(op, arg)
end

function execute(program)
    # print("executing ",program)
    accumulator = 0 
    loc = length(program)
    executedInstructions::Vector = zeros(Int,loc)
    pointer = 1
    while pointer <= length(program) 
        if executedInstructions[pointer] == 0
            instruction = program[pointer]
            if instruction.op == "nop"
                executedInstructions[pointer] += 1
                pointer += 1
            elseif instruction.op == "acc"
                accumulator += instruction.arg
                executedInstructions[pointer] += 1
                pointer += 1
            elseif instruction.op == "jmp"
                executedInstructions[pointer] += 1
                pointer += instruction.arg
            end
        else
            println(" result=", 0)
            return 0 
        end
    end
    println(" result=", accumulator)
    return accumulator
end

function changeInstruction(program, pointer)
    instruction = program[pointer]
    currOp = instruction.op
    if currOp == "nop"
        instruction.op = "jmp"
    else
        instruction.op = "nop"
    end
    program[pointer] = instruction
    #println("Changed instruction to ", instruction.op)
    return program
end

function fix(program)
    pointer = 1
    result = 0
    while result == 0 
        # println("pointer=", pointer)
        result = execute(program)
        if result == 0 
            changeInstruction(program, pointer)
            result = execute(program)
            if (result == 0)
                changeInstruction(program, pointer)
                pointer += 1
                while program[pointer].op == "acc"
                    if pointer < length(program) 
                        pointer += 1
                        # println("skipping acc")
                    end
                end
            end
        end
    end
    println("success",result)
end

program = []
open("data.txt") do file
    for line in eachline(file)
        instruction = instructionParser(line)
        push!(program, instruction)
    end
end

fix(program)