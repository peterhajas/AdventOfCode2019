#!/usr/bin/awk -f
BEGIN{
}
# returns whether a password is valid
# "n" means no, "y" means yes
function isPasswordValid(password) {
    passwordLength=length(password);
    lastSeenDigit = 100
    hasRepeatedDigits = 0
    hasDescendedDigits = 0
    for (i = 0; i < passwordLength; i++) {
        digitAtIndex = int(substr(password, i+1, 1));
        if (i != 0) {
            if (digitAtIndex == lastSeenDigit) { hasRepeatedDigits = 1; }
            if (digitAtIndex < lastSeenDigit) { hasDescendedDigits = 1; }
        }
        lastSeenDigit = digitAtIndex;
    }
    if (hasRepeatedDigits == 1 && hasDescendedDigits == 0) {
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
