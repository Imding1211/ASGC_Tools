
import sys
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

try:
	mode = sys.argv[1]
except:
	mode = ''

for stor in stor_list:

	cmd = "ssh "+ui+" bash "+script_path+"zpool_status.sh "+stor+" > "+path+"\\status.log"
	os.system(cmd)

	with open(path+'\\status.log', 'r') as f:
		lines = f.readlines()

	for line in lines[12:-2]:
		str_list = list(filter(None, line.strip().split(' ')))
		
		if str_list[0][0:6] == 'raidz1' or str_list[0][0:6] == 'raidz3':
			if str_list[1] != 'ONLINE':
				if mode != 'check':
					cmd = "ssh "+ui+" bash "+script_path+"zpool_clear.sh "+stor+" "+str_list[0]
					os.system(cmd)
					print("Clear "+stor+" "+str_list[0])

				else:
					print(stor+" "+str_list[0])

	for line in lines[-6:-2]:
		try:
			str_list = list(filter(None, line.strip().split(' ')))
			if str_list[1] == "UNAVAIL":
				print(stor, "spares", str_list[0], str_list[1])
		
		except:
			print(stor, "spares lost")

	cmd = "ssh "+ui+" bash "+script_path+"zpool_error_num.sh "+stor+" > "+path+"\\status.log"
	os.system(cmd)

	with open(path+'\\status.log', 'r') as f:
		errors = f.readlines()

	if lines[-1].split(":")[1].split(',')[0].strip() != "No known data errors":
		print(stor+lines[-1].split(":")[1].split(',')[0], "Unlink", errors[0].strip(), "error files")