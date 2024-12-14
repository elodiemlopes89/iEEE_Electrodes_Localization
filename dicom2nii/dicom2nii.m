function par = dicom2nii(src, outfile)
%% Converting DICOM to NIFTI for 4D data
%
% Syntax:
%   [filename, par] = dicom2nii(src, [options])
%
% Description:
%   This function is an extension of the DICOM-to_NIFTI converter
%   'dicm2nii'. It converts a set of DICOM files to NIFTI format 
%   for 4D data. It supports the automatic conversion to a 4D NIFTI 
%   file.
%
% Input Arguments:
%   src     - the directory where DICOM files are located.
%   outfile - the output NIFTI file.
%
% Output Arguments:
%   par     - a structure of DICOM parameters.
%
% Examples:
%   dicom2nii('dcm','out.nii.gz'); 
%
% See also 
%
% References:
%
% Notes:
% 1. This function requires the DICOM-to_NIFTI converter dicm2nii.
%    https://www.mathworks.com/matlabcentral/fileexchange/42997-dicom-to-nifti-converter--nifti-tool-and-viewer
% 2. This function requires FSL, and works on Linux.
%
% History:
%   07/14/2016 - initial script.
%
%__________________________________________________________________________
% Wonsang You(wsgyou@gmail.com)
% 07/14/2016
% Copyright (c) 2016 Wonsang You.


%% converting DCM to NIFTI for each volume
path_str = fileparts(outfile);
niidir   = fullfile(path_str,'nii');
subject  = dicm2nii(src, niidir, '3D.nii.gz');
data     = load(fullfile(niidir,'dcmHeaders.mat'));
prefix   = fieldnames(data.h);

%% concatenating 3D volumes into a 4D NIFTI files
system(sprintf('full_list=`imglob %s_?????.*`;fslmerge -t %s $full_list',fullfile(niidir,prefix{1}),outfile),'-echo');
system(sprintf('rm -f %s',niidir));
