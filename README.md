# iEEE_Electrodes_Localization

## Summary
Epilepsy is the second most common neurological disease, characterized by recurrent seizures. Antiepileptic drugs are the main treatment option in epilepsy. However, about 30% of patients are pharmacoresistant. In these patients, resective surgery, in which a part of the brain is removed or disconnected, is an effective therapeutic option. 

The success of epilepsy surgery strongly depends on the presurgical evaluation phase, in which the areas to be removed are defined as precise as possible, as well as the eloquent areas, i.e., areas that directly control brain functions that, if removed, produce neurological deficits. Seizure semiology, neuroimaging, scalp electroencephalography (EEG) and neuropsychologic testing are the main non-invasive multi-disciplinary methods used during surgery planning. When there is no agreement between these noninvasive methods, intracranial electroencephalography (iEEG) is usually required during the presurgical diagnosis. The interpretation of the iEEG data can be enhanced by an exact detection of the position of the electrodes on the cortex. Therefore, the epileptogenic foci and the eloquent areas can be more accurately defined. 

In this project, a friendly and interactive MATLAB interface was developed to accurately detect the intracranial EEG electrodes on each patient’ brain, using a pre-operative MRI and a post- operative CT image, either in DICOM or NIfTI format. For this purpose, FMRIB Software Library (FSL) shell script files were created and integrated into the interface. As an output, a 3D model of the MRI dataset with the electrodes masks is created. 

This tool was tool was used in one iEEG epileptic patient from Munich University Hospital. As a final result, six depth electrodes were visualized on the right frontal cortex of the patient brain. No beam hardening, artefacts or skull were identified in the final model. 
We concluded that the neuroimaging tool created, can be widely used for 3D visualization of iEEG electrodes defined on the patient cortex. Further testing is necessary to validate with higher accuracy the tool developed in this work. 

This tool was conducted under the Doctoral Program of Biomedic Engineering (Faculty of Engineering of University of Porto), under the PhD thesis "Novel Contributions to Personalized Brain Stimulation Biomarkers for Better Management of Neurological Disorders", supervised by Prof. João Paulo Cunha (INESC TEC, Porto, Portugal).

## Graphical User Interface
The MATLAB Graphical User interface (GUI) provides a "point-and-click control" of many soft- ware applications. The GUI typically contains controls such as menus, toolbars, buttons, and sliders.

In this project, 5 panels, 3 button groups, 5 pushbuttons, 1 slider, 1 static text and 1 edit text were added to the MATLAB GUI. The GUIs file was designated as "final_guide2.m". Prior to its use, the user must update the FSL directory name, fsldir, present in line number 259 of the mfile.

The five panels included in the interface were designed to perform a specific task. These panels
are listed from 1 to 5, since they are organized in a hierarchical manner. For each panel/task, a corresponding folder was created within the GUIs main folder, in which the resulting brain volumes and the FSL sh files created for each panel were saved.

After executing the task of each panel, the message "Ready!" is displayed in the MATLAB Command Window, warning the user that the considered function has been completed. Each GUI panel is described as bellow.

### Panel 1: Upload Images
The first GUI panel allows the user to upload the MRI (that contains the patient brain) and the CT images (that contains the implanted electrodes), either in DICOM or NIfTI format. The DICOM files are automatically converted into NIfTI files in this panel, by a MATLAB function (dicom2nii). After this step, the output brain volumes are renamed to MRI.nii.gz and CT.nii.gz and saved in the GUIs folder input.

The conversion of DICOM files into NIfTI was made by the MATLAB function DICOM to NIfTI
Converter for 4D Data, available in https://www.mathworks.com/matlabcentral/fileexchange/ 58239-dicom-to-nifti-converter-for-4d-data.

This function can be found in the MATLAB GUI folder dicom2nii and it has an input one DICOM file or zip or a tgz file, containing several DICOM files. After the conversion, a nii.gz volume is generated. The converted file is renamed to MRI.nii.gz or CT.nii.gz and then saved in the MATLAB GUIs folder input.

### Panel 2: Brain Extraction
The second panel allows the user to perform brain extraction, with the prior definition of the fractional intensity threshold value, ranging from 0 to 1. After this step, a skull-stripped MRI is originated, designated as MRI_brain.nii.gz. This brain volume is then saved in the folder "do_BET".

### Panel 3: Co-registration
The third panel allows the user to perform registration between the MRI_brain.nii.gz and the CT.nii.gz volumes. To realign these two images, the user can choose one of the following trans- formations:
* 6dof: linear rigid body transformation with 6 degrees of freedom;
* 12dof: linear affine transformation with 12 degrees of freedom;

As a result, a volume output, named MRI_CT.nii.gz, is generated and saved in the folder "registration".


### Panel 4: Electrodes Segmentation
In the fourth panel, the electrodes are segmented from the MRI volume, using an intensity threshold value, that must be previously defined by the user. As a result, two volumes are generated, the CT_seg.nii.gz and the CT_seg_mul.nii.gz and saved in the folder "segmentation".

### Panel 5: Visualization
The fifth panel allows the user to visualize the volumes obtained in each panel on the FSL image viewer, the FSLeyes, by selecting one of the five options in the MATLAB GUI: Volume #1, Volume #2, Volume #3, Volume #4 and Final Volume. 

For the 3D visualization of iEEG electrodes, the 3D view option of the FSLeyes must be selected by the user, during the visualization of the Final Volume, in menu Tools → View → 3D view. To increase the electrodes-cortex contrast, some display settings must be taken into consideration, such as:
* The number of samples in the 3D display settings must be set to 500;
* The opactiy of the MRI brain volume might be slighty reduced until a good contrast is achieved in electrodes;
* The colourmap of CT electrodes must be changed for a different color from the brain.

## System Function
In this project, FSL sh files were created for brain extraction, registration and electrodes segmen- tation. To run these files in the MATLAB GUI, the MATLAB function system was used, defined as

>> system(′sh file.sh′)

This function calls upon the operating system to run the command and directs the output to MATLAB. If the command runs successfully, a 0 will appear in the MATLAB Command Win- dow, otherwise, a nonzero value and an explanatory message appear. For more information about the System Function, please consult https://www.mathworks.com/help/matlab/ref/ system.html.

## FSL shell scripts
FSL sh scripts created for brain extraction, registration and electrodes segmentation. These files were running in the FSL 6.0.0 version.

### Brain Extraction Shell Script (bet_script.sh)
>> bet MRI.nii.gz MRI_brain.nii.gz −f FIT −g 0 −m

FIT: Fractional Intensity Threshold.

### Co-registration Shell Script (CR_xDOF.sh)
>> echo START : FLIRT
>> Out =′ ${ f sldir}/bin/ f lirt − in CT.nii.gz −out MRI_CT.nii.gz − omat MRI_CT.mat −searchrx 30 30 −searchry 30 30 −searchrz 30 30 −dof x′ echo $Out echo END : FLIRT

x: degrees of freedom.

### iEEG Electrodes Segmentation Shell Script
intensity_threshold.sh:
>> fslmaths MRI_CT.nii.gz −thr IT MRI_CT_seg.nii.gz

IT: intensity threshold.

multiplication.sh:
>> fslmaths MRI_brain.nii.gz −mul MRI_CT_seg.nii.gz MRI_CT_seg_mul.nii.gz


