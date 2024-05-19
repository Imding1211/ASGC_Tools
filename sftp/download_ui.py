
import fnmatch
import pysftp
import os

#==============================================================================
"""
Hostname = "bioswan-dev.twgrid.org" #IP位置
Username = "centos" #使用者名稱
Password = "" #使用者密碼

get_name = "bioswan-dev" #要上傳的檔案名稱

remote_Path = '/home/centos' #下載位置，必須為資料夾
local_Path  = 'C:/Users/user/OneDrive/桌面/download' #存檔位置，必須為資料夾

#------------------------------------------------------------------------------
"""
Hostname = "asgc-ui03.grid.sinica.edu.tw" #IP位置
Username = "imding1211" #使用者名稱
Password = "" #使用者密碼

get_name = "*.gz" #要上傳的檔案名稱

remote_Path = '/asgc_ui_home/imding1211/hostname_ca/hpstor/hpstor21/CHI-HENG_TING_9694302023-09-15_01-27-18' #下載位置，必須為資料夾
local_Path  = 'C:/Users/user/OneDrive/桌面/download' #存檔位置，必須為資料夾

#==============================================================================

def checkpath(path):
    
    if path[-1] != "/":
        path = path + str("/")
        
    return path

#------------------------------------------------------------------------------

def checkUsername(Username):
    
    if Username == "":
        pass

    elif Username[-1] != "@":
        Username = Username + str("@")
        
    return Username

#------------------------------------------------------------------------------

def download(Path):

    for name in sftp.listdir_attr(Path):
        if fnmatch.fnmatch(name.filename, get_name):
            try:
                sftp.get(Path+name.filename, local_Path+name.filename)
                if os.path.isfile(local_Path+name.filename):
                    print("Download\t", name.filename, "\t", name.st_size, "KB")
                    
            except:
                os.remove(local_Path+name.filename)

#==============================================================================

Username    = checkUsername(Username)
remote_Path = checkpath(remote_Path)
local_Path  = checkpath(local_Path)
ui_Path     = '/asgc_ui_home/imding1211/.temp/'+remote_Path.split('/')[-2]+'/'

print("Download file: "+get_name+" from "+remote_Path+" to "+local_Path+" ? ", end='')
ans = input("[y/n]:")

if ans == 'y' and remote_Path.split('/')[-2] != "root":

    with pysftp.Connection(host = "asgc-ui03.grid.sinica.edu.tw", username = "imding1211") as sftp:

        print("Connection succesfully established ... ")

        if Hostname != "asgc-ui03.grid.sinica.edu.tw":
            sftp.execute('bash /asgc_ui_home/imding1211/.temp/download.sh '+Username+Hostname+' '+remote_Path)
            download(ui_Path)
            sftp.execute('rm -rf '+ui_Path)

        else:
            download(remote_Path)
        
    print("Disconnect")

else:
    print("Cancel")