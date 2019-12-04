#!/usr/bin/awk -f
BEGIN{
    shortestIntersection = 10000000000;
}

function getWireGrid(gx, gy) {
    return grid[gx","gy];
}

function setWireGrid(gx, gy, val) {
    grid[gx","gy] = val;
}

function getTraversedGrid(w, gx, gy) {
    return traverseGrid[w","gx","gy];
}

function setTraversedGrid(w, gx, gy, t) {
    traverseGrid[w","gx","gy] = t;
}

# thanks mse
function abs(v) { return (v<0)?-v:v }

{
    x = 0;
    y = 0;
    setWireGrid(x, y, "");
    travelled = 0;
    # for each line of wires, we'll split the line into its component paths
    # split() is the awk function to divide a string into pieces
    pathCount = split($0, paths, ",")
    for(i = 1; i<pathCount + 1; i++) {
        path = paths[i];
        direction = substr(path, 0, 1)
        pathStringLength = length(path)
        # this is a VERY load bearing int
        stepAmount = int(substr(path, 2, pathStringLength-1))

        # now step in the direction marking the grid
        for(j = 0; j<stepAmount; j++) {
            if (getWireGrid(x, y) != "" && getWireGrid(x, y) < NR) {
                # This is an intersection
                # Grab the other wire's distance for this spot
                otherDistance = getTraversedGrid(NR-1, x, y)
                distance = travelled + otherDistance;
                if (distance < shortestIntersection) {
                    shortestIntersection = distance;
                }
            }
            setWireGrid(x, y, NR);
            if (direction == "R") { x+=1; }
            if (direction == "L") { x-=1; }
            if (direction == "U") { y-=1; }
            if (direction == "D") { y+=1; }

            travelled += 1;
            setTraversedGrid(NR, x, y, travelled);
        }
    }
}
END{
    print(shortestIntersection);
}
