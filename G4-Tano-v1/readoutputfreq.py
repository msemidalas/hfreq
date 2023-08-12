import sys
import re

if len(sys.argv) < 2:
    print("Please provide the filename as a command-line argument.")
    sys.exit()

filename = sys.argv[1]

print("Wavenumbers in cm-1")
with open(filename) as inputfile:
    text = inputfile.read()

start = text.find('post-proj  all modes:')
end = text.find(']', start)

if start != -1 and end != -1:
    result = text[start:end+1]
    modes = re.findall(r'[+-]?[\d.]+(?:[eE][+-]?\d+)?', result)  
    modes = [mode.strip("'") for mode in modes]  

    print(f"{filename}")
    for mode in modes:
        print(mode)
else:
    print("Substring not found.")
