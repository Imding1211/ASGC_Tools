
import fnmatch
import pysftp
import os

#==============================================================================

Hostname = "asgc-ui03.grid.sinica.edu.tw" #IP位置
Username = "imding1211" #使用者名稱
Password = "" #使用者密碼

get_name = "*.sh" #要上傳的檔案名稱

remote_Path = '/asgc_ui_home/imding1211/test' #上傳位置，必須為資料夾
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

def upload(Path):

    for name in os.listdir(local_Path):
        if fnmatch.fnmatch(name, get_name):
            sftp.put(local_Path+name, Path+name)
            print("Upload\t", name, "\t", os.stat(local_Path+name).st_size, "KB")

#==============================================================================

Username    = checkUsername(Username)
remote_Path = checkpath(remote_Path)
local_Path  = checkpath(local_Path)
dir_Path    = checkpath('/'.join(remote_Path.split('/')[0:-2]))
ui_Path     = '/asgc_ui_home/imding1211/.temp/'+remote_Path.split('/')[-2]+'/'

print("Upload file: "+get_name+" from "+local_Path+" to "+remote_Path+" ? ", end='')
ans = input("[y/n]:")

if ans == 'y' and remote_Path.split('/')[-2] != "root":
    
    with pysftp.Connection(host = "asgc-ui03.grid.sinica.edu.tw", username = "imding1211") as sftp:

        print("Connection succesfully established ... ")

        if Hostname != "asgc-ui03.grid.sinica.edu.tw":
            sftp.execute('mkdir '+ui_Path)
            upload(ui_Path)
            sftp.execute('bash /asgc_ui_home/imding1211/.temp/upload.sh '+Username+Hostname+' '+remote_Path.split('/')[-2]+' '+dir_Path)
            sftp.execute('rm -rf '+ui_Path)

        else:
            upload(remote_Path)

    print("Disconnect")

else:
    print("Cancel")