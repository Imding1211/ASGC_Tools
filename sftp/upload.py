
import fnmatch
import pysftp
import os

#==============================================================================

Hostname = "202.169.170.41" #IP位置
Username = "root" #使用者名稱
Password = "" #使用者密碼

get_name = "*.py" #要下載的檔案名稱

remote_Path = '/root/test/' #下載位置，必須為資料夾
local_Path  = 'C:/Users/user/OneDrive/桌面/download' #存檔位置，必須為資料夾

#==============================================================================

def checkpath(path):
    
    if path[-1] != "/":
        path = path + str("/")
        
    return path

#==============================================================================

remote_Path = checkpath(remote_Path)
local_Path = checkpath(local_Path)

#with pysftp.Connection(host = Hostname, username = Username, password = Password) as sftp:
with pysftp.Connection(host = Hostname, username = Username) as sftp:

    print("Connection succesfully established ... ")

    for name in os.listdir(local_Path):
        if fnmatch.fnmatch(name, get_name):
            if name in sftp.listdir(remote_Path):
                print("Upload", name, "? ", end='')
                ans = input("[y/n]:")
                if ans == "y":
                    sftp.put(local_Path+name, remote_Path+name)
                    print("Upload\t", name, "\t", os.stat(local_Path+name).st_size, "KB")
                    
                elif ans == "n":
                    print("Cancel")

            else:
                sftp.put(local_Path+name, remote_Path+name)
                print("Upload\t", name, "\t", os.stat(local_Path+name).st_size, "KB")
                    
print("Disconnect")