# -*- coding: utf-8 -*-
"""
Created on Tue Sep 19 09:03:55 2023

@author: user
"""

def readtxt(file_path):
    
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    lines_list = []
    
    for line in lines:
        lines_list.append(line.split(":",1)[1].split(" ")[1].strip())
        
    return lines_list

#------------------------------------------------------------------------------

def convert(data_list):
    
    print("#!bin/bash")
    print("")
    
    for line in data_list:
        print('dmlite-shell -e "getlfn '+ line +'"')

#------------------------------------------------------------------------------

data = readtxt('hpstor11_lostdata.txt')

convert(data)