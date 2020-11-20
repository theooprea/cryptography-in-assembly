Iocla Assignment 2 - by Theodor-Alin Oprea 324CC
time to implement aprox 15 - 20 hours

One Time Pad - Task 1 - encode a string by xor-ing each character with the
corresponding letter from a key. I iterate through the string, xor the current
letter with the current letter from the key and put it in the answer string.

Caesar Cypher - Task 2 - Shift letters with the value of the key, for example
Azazel with the key = 1 becomes Babafm. I iterate through the string, check to
see if the character is letter or not, if it is letter i add the value of the
key and get the resulting letter, checking if there occured a letter overflow,
for example, if z has to be brought back to a. This check is made with the
formula (letter + cod - 97) mod 26 + 97 for small letter and (letter + cod - 65
) mod 26 + 65 for upper letters.

Vigenere Cypher - Task 3 - Similar to Caesar Cypher, only that the key for each
letter is the corresponding letter form the keystring. For example if we have a
a string: Donald Trump and a key BIDEN, we extend the key to BIDENB IDENBI to
match the size of the string. For each letter in the string we add the
corresponding letter from the key and turn it back to a letter similarly to how
we did for the Caesar Cypher. I keep 2 iterators, one for the string and one
for the key, when the second iterator is the length of the original key(BIDEN)
we reset it to 0. Thus, we iterate through the original string and turn each
letter to the coresponding final letter.

Strstr - Task 4 -Searches for a substring (needle) in a string (haystack),
returning the first position where the substring is found, or if not found we
return the length of the initial string + 1. I iterate through the haystack and
when i find the first letter of the needle I check to see if that is the actual
needle, if it is, I return the starting position of the first letter found,
else I keep iterating through the haystack.

Binary to Hexadecimal - Task 5 - Turn a binary string to a hex string. I group
the bits in groups of 4 and turn them to decimal, then to hexa and add them to
the answer string. The first 1, 2 or 3 bits (depinding on if the number of
initial bits is dividable by 4) are treated sepparately, added together and
turned to hex. After the first bits that cannot be put into groups of 4, we
move on to the groups that are processed as descriped.
