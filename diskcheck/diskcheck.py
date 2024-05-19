
import sys
import os

stor_name = sys.argv[1]

ui = 'imding1211@asgc-ui03.grid.sinica.edu.tw'
path = os.path.split(os.path.abspath(__file__))[0]

cmd = "ssh "+ui+" bash /asgc_ui_home/imding1211/zpool/zpool_status.sh "+stor_name+" > "+path+"\\status.log"
os.system(cmd)
    
with open(path+'\\status.log', 'r') as f:
    lines = f.readlines()
    
    pool_data=[]
    
    for line in lines:

        str_list = list(filter(None, line.strip().split(' ')))
        
        try:
            if str_list[0][0:4] == "scsi" or str_list[0][0:3] == "wwn":
                if len(str_list[0].split('-')) < 3:
                    pool_data.append("wwn-0x" +str_list[0][6:])
            
        except:            
            pass

cmd = "ssh "+ui+" bash /asgc_ui_home/imding1211/zpool/zpool_disklist.sh "+stor_name+" > "+path+"\\disklist.log"
os.system(cmd)

with open(path+'\\disklist.log', 'r') as f:
    lines = f.readlines()
    
    id_data=[]
    for line in lines:
        if line.strip() != "End":
            id_data.append(line.strip())
        else:
            break
            
    for line in lines[::-1]:
        if line.strip() != "End":
            id_data.remove(line.strip().rsplit("-",1)[0])
        else:
            break

pool_data = list(set(pool_data))
id_data = list(set(id_data))

print("pool - by-id :", list(set(pool_data)-set(id_data)))
print("by-id - pool :", list(set(id_data)-set(pool_data)))
