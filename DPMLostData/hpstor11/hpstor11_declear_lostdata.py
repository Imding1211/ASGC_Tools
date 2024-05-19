# -*- coding: utf-8 -*-
"""
Created on Tue Sep 19 09:56:10 2023

@author: user
"""

def readtxt(file_path):
    
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    lines_list = []
    
    for line in lines:
        if len(line) > 1:
            lines_list.append(line.strip())
        
    return lines_list

#------------------------------------------------------------------------------

def printout(data_list):
    
    with open("LostData_1.txt", 'w') as file:
        for line in data_list[0:]:
            file.write("davs://f-dpm000.grid.sinica.edu.tw"+line+"\n")
"""            
    with open("LostData_2.txt", 'w') as file:
        for line in data_list[12856:25712]:
            file.write("davs://f-dpm000.grid.sinica.edu.tw"+line+"\n")
            
    with open("LostData_3.txt", 'w') as file:
        for line in data_list[25712:]:
            file.write("davs://f-dpm000.grid.sinica.edu.tw"+line+"\n")
"""          
#------------------------------------------------------------------------------

data = readtxt('hpstor11_declare_lostdata.txt.bak')

printout(data)