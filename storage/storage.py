
import os

#==============================================================================

path = os.path.split(os.path.abspath(__file__))[0]

ui = 'imding1211@asgc-ui03.grid.sinica.edu.tw'

script_path = '/asgc_ui_home/imding1211/storage/'

stor_list_11_15 = [
'hpstor11',
'hpstor12',
'hpstor13',
'hpstor14',
'hpstor15']

stor_list_16_22 = [
'hpstor16',
'hpstor17',
'hpstor18',
'hpstor19',
'hpstor20',
'hpstor21',
'hpstor22']

stor_list_32_36 = [
'smstor32',
'smstor33',
'smstor34',
'smstor35',
'smstor36']

#==============================================================================

def check_hp_physicaldrive(ui_in, script_in, path_in, stor_list_in):

	for stor in stor_list_in:

		cmd = "ssh "+ui_in+" bash "+script_path+"storage.sh "+stor+" hp_pd > "+path_in+"\\physicaldrive.log"
		os.system(cmd)

		with open(path_in+'\\physicaldrive.log', 'r') as f:
			lines = f.readlines()

		num = []
		for line in lines[3:-1]:
			str_list = list(filter(None, line.strip().split(' ')))

			if len(str_list) > 2:
				num.append(int(str_list[1].split(':')[-1]))

				if ' '.join(str_list[10:])[:-1] != "OK":
					print(stor, str_list[0], str_list[1], ' '.join(str_list[10:])[:-1])

		compare = list(set(list(range(1, 61)))-set(num))
		if len(compare) > 0:
			print(stor, "lost physicaldrive:", ','.join(str(x) for x in compare))

#------------------------------------------------------------------------------

def check_sms_physicaldrive(ui_in, script_in, path_in, stor_list_in):

	for stor in stor_list_in:

		cmd = "ssh "+ui_in+" bash "+script_path+"storage.sh "+stor+" sms_pd > "+path_in+"\\physicaldrive.log"
		os.system(cmd)
		
		with open(path_in+'\\physicaldrive.log', 'r') as f:
			lines = f.readlines()

		num = []
		for line in lines[13:-13]:
			str_list = list(filter(None, line.strip().split(' ')))

			try:
				num.append(int(str_list[3].split(':')[-1]))
			except:
				pass

			if str_list[2] != "Onln":
				print(stor, "physicaldrive", str_list[0], str_list[2])

		compare = list(set(list(range(0, 36)))-set(num))
		if len(compare) > 0:
			print(stor, "lost physicaldrive DG:", ','.join(str(x) for x in compare))
		
#------------------------------------------------------------------------------

def check_hp_logicaldrive(ui_in, script_in, path_in, stor_list_in):

	for stor in stor_list_in:

		cmd = "ssh "+ui_in+" bash "+script_path+"storage.sh "+stor+" hp_ld > "+path_in+"\\logicaldrive.log"
		os.system(cmd)

		with open(path_in+'\\logicaldrive.log', 'r') as f:
			lines = f.readlines()

		num = []
		for line in lines[3:-1]:
			str_list = list(filter(None, line.strip().split(' ')))

			if len(str_list) > 2:
				num.append(int(str_list[1].split(':')[-1]))

				if ' '.join(str_list[6:])[:-1] != "OK":
					print(stor, str_list[0], str_list[1], ' '.join(str_list[6:])[:-1])

		compare = list(set(list(range(1, 61)))-set(num))
		if len(compare) > 0:
			print(stor, "lost logicaldrive:", ','.join(str(x) for x in compare))

#==============================================================================

check_hp_physicaldrive(ui, script_path, path, stor_list_11_15)
check_hp_logicaldrive(ui, script_path, path, stor_list_11_15)
check_hp_physicaldrive(ui, script_path, path, stor_list_16_22)
check_sms_physicaldrive(ui, script_path, path, stor_list_32_36)