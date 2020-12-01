rawdata = []
open("data.txt") do file
    for line in eachline(file)
        push!(rawdata,parse(Int,line))
    end
end

sorteddata = sort(rawdata)

for y in 200:-1:1
    x = 1
    a = sorteddata[x]
    b = sorteddata[y]
    while (a + b != 2020)
        println("x=", x)
        println("y=", y)
        println("a=", a)
        println("b=", b)
        if (a + b < 2020)
            x += 1
            a = sorteddata[x]
        end
        if (a + b > 2020)
            break
        end
        if a + b == 2020 
            println("Found it")
            println("a=", a)
            println("b=", b)
            answer = a * b
            println("answer=", answer)
            exit(0)
        end
    end
end




