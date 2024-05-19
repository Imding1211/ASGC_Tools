
with open('LFN.txt', 'r', encoding='utf-8') as f:
    lines = f.readlines()

data=[]
for line in lines:
    if line[0] == "/":
        data.append(line.rstrip('\n'))

with open('Logical_File_Name_1.txt', 'w', encoding='utf-8') as f:
    for line in data[0:9477]:
        f.write(f'davs://f-dpm000.grid.sinica.edu.tw{line}'+'\n')

with open('Logical_File_Name_2.txt', 'w', encoding='utf-8') as f:
    for line in data[9477:18954]:
        f.write(f'davs://f-dpm000.grid.sinica.edu.tw{line}'+'\n')

with open('Logical_File_Name_3.txt', 'w', encoding='utf-8') as f:
    for line in data[18954::]:
        f.write(f'davs://f-dpm000.grid.sinica.edu.tw{line}'+'\n')