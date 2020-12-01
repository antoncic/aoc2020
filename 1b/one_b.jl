rawdata = []
open("data.txt") do file
    for line in eachline(file)
        push!(rawdata,parse(Int,line))
    end
end

sorteddata = sort(rawdata)





