lines = map(collect, readlines("data_x99.txt"))
data = permutedims(hcat(lines...))

function countTrees(data)
    trees = 0
    println(typeof(data))

    rows = size(data)[1]
    cols = size(data)[2]
    println("cols=", cols, " rows=", rows)
    col = 1
    for row in 1:rows
        println("row=", row, " col=", col)
        if(data[row,col] == '#')
            println(data[row,col])
            trees += 1
        end
        col += 3
        if(col > cols)
            break
        end 
    end
    return trees
end

println("# trees = ", countTrees(data))
