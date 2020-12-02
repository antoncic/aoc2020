rawdata = []
open("data.txt") do file
    for line in eachline(file)
        push!(rawdata,parse(Int,line))
    end
end

function printSuccess(a,b,c)
    println("Found it")
    println("a=", a)
    println("b=", b)
    println("c=", c)
    answer = a * b * c
    println("answer=", answer)
end

sorteddata = sort(rawdata)


for z in 200:-1:1
    x = 1
    y = x+1
    a = sorteddata[x]
    b = sorteddata[y]
    c = sorteddata[z]

    while (a + b + c != 2020)
        println("x=", x," y=", y, " z=", z, " a=", a, " b=", b, " c=", c)
        if (a + b + c > 2020)
            break
        end
        if (a + b + c < 2020)
            for x in 1:100 
                if (a + b + c < 2020)
                    if (a + b + c < 2020)
                        y += 1
                        b = sorteddata[y]
                    end
                    if (a + b + c > 2020)
                        break
                    end
                    if a + b + c == 2020 
                        printSuccess(a,b,c)
                        exit(0)
                    end
                end
                if (a + b + c < 2020)
                    x += 1
                    a = sorteddata[y]
                end
                if (a + b + c > 2020)
                    break
                end
                if a + b + c == 2020 
                    printSuccess(a,b,c)
                    exit(0)
                end
                x += 1
                a = sorteddata[x]
            end
        end

        if (a + b + c == 2020)
            printSuccess(a,b,c)
            exit(0)
        end
    end
end

