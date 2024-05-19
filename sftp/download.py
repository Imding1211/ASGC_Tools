
import fnmatch
import pysftp
import os

#==============================================================================

Hostname = "asgc-ui03.grid.sinica.edu.tw" #IP位置
Username = "imding1211" #使用者名稱
Password = "" #使用者密碼

get_name = "*.sh" #要下載的檔案名稱

remote_Path = '/asgc_ui_home/imding1211/zpool' #下載位置，必須為資料夾
local_Path  = 'C:/Users/user/OneDrive/桌面/' #存檔位置，必須為資料夾

#==============================================================================

def checkpath(path):
    
    if path[-1] != "/":
        path = path + str("/")
        
    return path

#==============================================================================

remote_Path = checkpath(remote_Path)
local_Path  = checkpath(local_Path)

#with pysftp.Connection(host = Hostname, username = Username, password = Password) as sftp:
with pysftp.Connection(host = Hostname, username = Username) as sftp:

    print("Connection succesfully established ... ")
    
    for name in sftp.listdir_attr(remote_Path):
        if fnmatch.fnmatch(name.filename, get_name):
            try:
                sftp.get(remote_Path+name.filename, local_Path+name.filename)
                if os.path.isfile(local_Path+name.filename):
                    print("Download\t", name.filename, "\t", name.st_size, "KB")
                    
            except:
                os.remove(local_Path+name.filename)
    
print("Disconnect")