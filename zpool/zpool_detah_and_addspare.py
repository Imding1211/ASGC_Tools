
import sys
import os

stor_name=sys.argv[1]
pool_name=sys.argv[2]
fail_disk=sys.argv[3]

ui = 'imding1211@asgc-ui03.grid.sinica.edu.tw'

cmd = "ssh "+ui+" bash /asgc_ui_home/imding1211/zpool/zpool_detach_and_addspare.sh "+stor_name+" "+pool_name+" "+fail_disk
os.system(cmd)