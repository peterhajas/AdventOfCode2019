#!/usr/bin/awk -f
BEGIN{
}
function isPasswordValid(password) {
    passwordLength=length(password);
    lastSeenDigit = 100
    hasRepeatedDigits = 0
    hasDescendedDigits = 0
    for (i = 0; i < passwordLength; i++) {
        print "processing "i
        digitAtIndex = int(substr(password, i+1, 1));
        if (i != 0) {
            if (digitAtIndex == lastSeenDigit) { hasRepeatedDigits = 1; }
            if (digitAtIndex < lastSeenDigit) { hasDescendedDigits = 1; }
        }
        lastSeenDigit = digitAtIndex;

        print digitAtIndex " has repeating " hasRepeatedDigits
        print digitAtIndex " has descending " hasDescendedDigits
    }
    print "has repeating " hasRepeatedDigits
    print "has descending " hasDescendedDigits
    if (hasRepeatedDigits == 1 && hasDescendedDigits == 0) {
        return "y";
    }
    return "n";
}
{
    print isPasswordValid($0);
}
END{
}
