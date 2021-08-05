function I = camCapture(camera)

% CAMCAPTURE Captures a frame from each active camera. 
%    CAMCAPTURE captures frame from camera(s) supported 
%    by the Matlab Image Acquisition Toolbox.
%    This script captures single frame per active camera
%   Refer to SIGGRAPH 2009 course notes for additional details.
%
%       D. Lanman and G. Taubin, "Build Your Own 3D Scanner: 3D 
%       Photography for Beginners", ACM SIGGRAPH 2009 Course 
%       Notes, 2009.
%
% Douglas Lanman and Gabriel Taubin 
% Brown University
% 28 May 2009

% Capture frame from camera(s) using Image Acquisition Toolbox.
nCameras = length(camera);
I = cell(1,nCameras);
for i = 1:nCameras
   
   % Restart camera (if it is not running).
   if strcmp(camera{i}.Running,'off')  %strcmp is for string compare
      start(camera{i});
   end
      
   % Capture an image (wait until new image is available).
   frmIdx = camera{i}.FramesAcquired;  % it stores the current value of frame index by asking for number of frames captured already
   trigger(camera{i});
   while frmIdx == camera{i}.FramesAcquired   % if number of frame index doesn't increase wait for the capture to occur and new image to be available
      pause(0.01);
   end
   I{i} = getdata(camera{i}); %stores the frame in cell of respective camera

end