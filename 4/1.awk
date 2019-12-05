#!/usr/bin/awk -f
BEGIN{
}

function lengthOfRunOfDigits(str, idx) {
    count = 0
    currentValue = int(substr(str, idx+1, 1));
    for (k = idx; k < length(str); k++) {
        valueAtIndex = int(substr(str, k+1, 1));
        if (valueAtIndex == currentValue) {
            count++;
        }
        else {
            break;
        }
    }
    return count
}

# returns whether a password is valid
# "n" means no, "y" means yes
function isPasswordValid(password) {
    passwordLength=length(password);
    lastSeenDigit = 0
    hasTwoRepeatedDigits = 0
    hasDescendedDigits = 0
    for (i = 0; i < passwordLength; i++) {
        digitAtIndex = int(substr(password, i+1, 1));
        digitRunLength = lengthOfRunOfDigits(password, i);
        if (digitRunLength == 2) {
            hasTwoRepeatedDigits = 1;
        }
        if (digitRunLength > 1) {
            i += digitRunLength-1
        }
        if (digitAtIndex < lastSeenDigit) {
            hasDescendedDigits = 1;
        }
        lastSeenDigit = digitAtIndex;
    }
    if (hasTwoRepeatedDigits == 1 && hasDescendedDigits == 0) {
        return "y";
    }
    return "n";
}
{
    start = ARGV[2];
    end = ARGV[3];
    range = end - start;
    validCount = 0;
    for (j = 0; j <= range; j++) {
        passwordInt = int(start) + j;
        passwordString = passwordInt""
        if (isPasswordValid(passwordString) == "y") {
            print "valid: "passwordString
            validCount++;
        }
    }
    print "total valid: "validCount
}
END{
}
