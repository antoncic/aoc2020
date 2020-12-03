lines = map(collect, readlines("data_x99.txt"))
data = permutedims(hcat(lines...))

movements = [(1,1),(3,1),(5,1),(7,1),(1,2)]


function countTrees(data, movement)
    c_move = movement[1]
    r_move = movement[2]
    trees = 0

    rows = size(data)[1]
    cols = size(data)[2]
    col = 1
    for row in 1:r_move:rows
        #println("row=", row, " col=", col)
        if(data[row,col] == '#')
            #println(data[row,col])
            trees += 1
        end
        col += c_move
        if(col > cols)
            break
        end 
    end
    println("Slope with movement ", movement, " has ", trees, " trees")
    return trees
end

function getResult(data, movements)
    result = 1
    for movement in movements
        result *= countTrees(data,movement)
    end
    return result
end

println("result = ", getResult(data, movements))

        

# 1,1 = 68
# 3,1 = 203
# 5,1 = 78
# 7,1 = 77
# 1,2 = 40

3316272960

