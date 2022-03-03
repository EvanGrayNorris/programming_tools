using Plots
#sample nearest neighbor listing code with periodic boundary conditions

function periodic_boundary(idx,bounds)
    #if index is beyond boundary of array set index behind opposite boundary by distance beyond intial boundary
    if idx < bounds[1]
        #recursion handles values that are further from the boundary than the length of the total array
        return periodic_boundary(bounds[2] +1 - abs(idx - bounds[1]),bounds)
    elseif idx > bounds[2]
        return periodic_boundary(bounds[1] -1 + abs(idx-bounds[2]),bounds)
    else
        idx
    end
end 

function list_neighbors(arr,position,bounds)
    #list the 8 nearest neighbors to a position in the array based on a square lattice
    neighbors = zeros(8,3)
    idx = 1
    posx = position[1];
    posy = position[2];
    for i = posx-1:posx+1
        for j= posy-1:posy+1
            i = periodic_boundary(i,bounds[1])
            j = periodic_boundary(j,bounds[2])
            if ~((i == posx) & (j == posy))
                neighbors[idx,:] = [arr[i,j],i,j]
                idx += 1
            end
        end
    end
    return neighbors
end

arr = zeros(10,8)
xbounds = [1,size(arr)[1]]
ybounds = [1,size(arr)[2]]
pos = [11,9]
#check the center position is actually in the array, if not apply perioi
pos = periodic_boundary.(pos,[xbounds,ybounds])
#println(periodic_boundary(11,bounds))
x = list_neighbors(arr,pos,[xbounds,ybounds])
#println("Value of Positions neighboring (",2,",",2,")")
for i = 1:size(x)[1]
    println("Value at (",x[i,2],",",x[i,3],"): ",x[i,1])
    arr[trunc(Int,x[i,2]),trunc(Int,x[i,3])] = 1
end
arr[pos[1],pos[2]] = -1
png(heatmap(arr),"array.png")

