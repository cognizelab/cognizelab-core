% setup_matlab_path.m
% Run this once per MATLAB session (or add to your startup.m) to make
% cognizelabcore.* functions available:
%
%   run('/path/to/cognizelab-core/matlab/setup_matlab_path.m')
%
% It adds this folder (and SPM/CONN helper subfolders) to the path so the
% +cognizelabcore package and spm/conn helper scripts are callable.

thisDir = fileparts(mfilename('fullpath'));
addpath(thisDir);                       % so +cognizelabcore package resolves
addpath(genpath(fullfile(thisDir, 'spm')));
addpath(genpath(fullfile(thisDir, 'conn')));
fprintf('cognizelab-core MATLAB paths added from: %s\n', thisDir);
