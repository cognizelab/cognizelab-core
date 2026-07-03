% setup_matlab_path.m
% Run this once per MATLAB session (or add to your startup.m) to make
% labcommon.* functions available:
%
%   run('/path/to/lab-common/matlab/setup_matlab_path.m')
%
% It adds this folder (and SPM/CONN helper subfolders) to the path so the
% +labcommon package and spm/conn helper scripts are callable.

thisDir = fileparts(mfilename('fullpath'));
addpath(thisDir);                       % so +labcommon package resolves
addpath(genpath(fullfile(thisDir, 'spm')));
addpath(genpath(fullfile(thisDir, 'conn')));
fprintf('lab-common MATLAB paths added from: %s\n', thisDir);
