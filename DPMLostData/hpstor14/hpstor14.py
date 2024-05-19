
with open('zpool_data_lost.txt', 'r', encoding='utf-8') as f:
    lines = f.readlines()

data=[]
for line in lines:
    if line[0] == "/":
        data.append(line.rstrip('\n'))

with open('tf.sh', 'w', encoding='utf-8') as f:
    for line in data:
        f.write(f'dmlite-shell -e "getlfn hpstor14.grid.sinica.edu.tw:{line}"'+'\n')

with open('hpstor14.sh', 'w', encoding='utf-8') as f:
    for line in data:
        f.write(f'bash /root/ding/dmlite.sh hpstor14 {line}'+'\n')