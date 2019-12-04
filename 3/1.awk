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

# thanks mse
function abs(v) { return (v<0)?-v:v }

{
    x = 0;
    y = 0;
    setWireGrid(x, y, "o")
    # for each line of wires, we'll split the line into its component paths
    # split() is the awk function to divide a string into pieces
    pathCount = split($0, paths, ",")
    for(i = 1; i<pathCount + 1; i++) {
        path = paths[i];
        direction = substr(path, 0, 1)
        # print direction
        pathStringLength = length(path)
        # this is a VERY load bearing int
        stepAmount = int(substr(path, 2, pathStringLength-1))
        print "stepping " direction " by " stepAmount

        # now step in the direction marking the grid
        for(j = 0; j<stepAmount; j++) {
            if (getWireGrid(x, y) == "-") {
                # This is an intersection
                distance = abs(x) + abs(y);
                if (distance < shortestIntersection) {
                    shortestIntersection = distance;
                }
            }
            setWireGrid(x, y, "-");
            if (direction == "R") { x+=1; }
            if (direction == "L") { x-=1; }
            if (direction == "U") { y-=1; }
            if (direction == "D") { y+=1; }
        }
    }
}
END{
    print(shortestIntersection);
}
