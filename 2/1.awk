#!/usr/bin/awk -f
BEGIN{
    RS=",";
}
{
    data[NR-1] = $1;
}

function prepareOperands(from) {
    indexOfOperand1 = data[from+1];
    indexOfOperand2 = data[from+2];
    indexOfDestination = data[from+3];
    operand1 = data[indexOfOperand1];
    operand2 = data[indexOfOperand2];
}

function add(from) {
    prepareOperands(from);
    data[indexOfDestination] = operand1 + operand2;
}

function mul(from) {
    prepareOperands(from);
    data[indexOfDestination] = operand1 * operand2;
}

function printData() {
    for (j = 0; j<NR; j++) {
        printf data[j] ","
    }
    print ""
}

END{
    data[1] = 12;
    data[2] = 2;

    for (i = 0; i<=NR; i+=4) {
        code = data[i];
        if (code == 99) { break; }
        if (code == 1) { add(i); }
        if (code == 2) { mul(i); }
        # printData()
    }
    # print output
    print "final: "
    printData();
}
