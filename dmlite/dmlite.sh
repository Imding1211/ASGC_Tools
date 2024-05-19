#!bin/bash

stor_name=${1}
lfn_name=${2}

unlink_name=$(dmlite-shell -e "getlfn "${stor_name}".grid.sinica.edu.tw:"${lfn_name})

dmlite-shell -e "unlink ${unlink_name} f"
