#!/bin/sh
#Variables



#fsldir=/usr/local/fsl
#rootDir=/Users/lopeselodie/Desktop/GUIDE_final2/input
#refDir=/Users/lopeselodie/Desktop/GUIDE_final2/do_BET
#refOut=/Users/lopeselodie/Desktop/GUIDE_final2/registration


#. dir_info.txt

#cr_dir="/Users/lopeselodie/Desktop/GUIDE_final2/registration"
#inp_dir="/Users/lopeselodie/Desktop/GUIDE_final2/input"
#bet_dir="/Users/lopeselodie/Desktop/GUIDE_final2/do_BET"
#fsldir="/usr/local/fsl"

. dir_info.txt

echo START: FLIRT
Out=`${fsldir}/bin/flirt -in ${inp_dir}/CT.nii.gz -ref ${bet_dir}/MRI_brain.nii.gz -out ${cr_dir}/MRI_CT.nii.gz -omat ${cr_dir}/MRI_CT.mat -bins 256 -cost normmi -searchrx -30 30 -searchry -30 30 -searchrz -30 30 -dof 6 `
echo $Out
echo END:  FLIRT

. dir_info.txt

#T12MNI
#1 FNIRT
echo START: FNIRT
Out=`${fsldir}/bin/fnirt --ref=${bet_dir}/MRI_brain.nii.gz --in=${inp_dir}/CT.nii.gz --aff=${cr_dir}/MRI_CT.mat --cout=${cr_dir}/MRI_CT`
echo $Out
echo END:  FNIRT

. dir_info.txt

#T12MNI
#1 APPLYWARP
echo START: applywarp
Out=`${fsldir}/bin/applywarp --in=${inp_dir}/CT.nii.gz --ref=${bet_dir}/MRI_brain.nii.gz --out=${cr_dir}/MRI_CT.nii.gz  --warp=${cr_dir}/MRI_CT`
echo $Out
echo END:  applywarp

