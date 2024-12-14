#!/bin/sh



. dir_info.txt

#cr_dir="/Users/lopeselodie/Desktop/GUIDE_final2/registration"
#inp_dir="/Users/lopeselodie/Desktop/GUIDE_final2/input"
#bet_dir="/Users/lopeselodie/Desktop/GUIDE_final2/do_BET"
#fsldir="/usr/local/fsl"


echo START: FLIRT
Out=`${fsldir}/bin/flirt -in ${inp_dir}/CT.nii.gz -ref ${bet_dir}/MRI_brain.nii.gz -out ${cr_dir}/MRI_CT.nii.gz -omat ${cr_dir}/MRI_CT.mat -bins 256 -cost normmi -searchrx -30 30 -searchry -30 30 -searchrz -30 30 -dof 6 `
echo $Out
echo END:  FLIRT





