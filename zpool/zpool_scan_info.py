
import os

#==============================================================================

ui = 'imding1211@asgc-ui03.grid.sinica.edu.tw'

script_path = 'asgc_ui_home/imding1211/zpool'

stor_list = [
'f-dpmp01',
'hpstor11',
'hpstor12',
'hpstor13',
'hpstor14',
'hpstor15',
'hpstor16',
'hpstor17',
'hpstor18',
'hpstor19',
'hpstor20',
'hpstor21',
'hpstor22',
'smstor32',
'smstor33',
'smstor34',
'smstor35',
'smstor36']

#==============================================================================

def checkpath(path):
    
    if path[-1] != "/":
        path = path + str("/")

    if path[0] != "/":
        path = str("/") + path

    return path

#==============================================================================

path = os.path.split(os.path.abspath(__file__))[0]

script_path = checkpath(script_path)

for stor_name in stor_list:
    
    cmd = "ssh "+ui+" bash "+script_path+"zpool_scan_info.sh "+stor_name+" > "+path+"\\scan.log"
    os.system(cmd)
    
    with open(path+'\\scan.log', 'r') as f:
        lines = f.readlines()

    cmd = "ssh "+ui+" bash "+script_path+"zpool_spare_num.sh "+stor_name+" > "+path+"\\spare.log"
    os.system(cmd)
    
    with open(path+'\\spare.log', 'r') as f:
        spare = int(f.readlines()[0])

    if len(lines) != 0:
        
        str_list = list(filter(None, lines[0].split(" ")))
        
        if str_list[1] == "resilver":
            print(stor_name, lines[-1].strip()+",", spare,"spare currently in use")

        if str_list[1] == "resilvered" and spare > 0:
            print(stor_name, lines[0].split(":",1)[1].strip()+",", spare,"spare currently in use")