%% load data (change the folder and the name of file here!!!)
addpath("D:\Project\LocalNotchFilter1.3_ByWei"); % add the folder to the path
% dat =double(tifread("snippet_downsample.tiff")); % read the data, the data must be dat(x,y,time)and should be double
dat=data0;
dat_mean=squeeze(mean(dat,[1 2])); % calcaulte the average curve
[P1,f,~]=FFTparameter(dat_mean,1);
plot(f,P1);
%% parameters
HighPassFilter_CircleLengthByPoint=20; % we will apply a high-pass filter to the original signal first and then find the frequency with largest remaining amplitude as our fundamental frequency
LowPassFilter_CircleLengthByPoint=10; % a low-pass filter threshold
Peak_num=1; % number of peaks to be removed
FilterWindowsSize=31; % the time window's size used to estimate the amplitude of the noise, here we use round(3/F0) as our time window
%% find fundamental frequency (based on the averaged curve: dat_mean)
F0=findFundamentalFrequency(dat_mean,HighPassFilter_CircleLengthByPoint,LowPassFilter_CircleLengthByPoint);
%% Remove Noise (main function)
F0Lst=[0.0076,0.0313,0.2003,0.4004,0.4891];
dat_re=removeArtifactV1_3(dat,F0Lst(1),5,1);
% dat_re=removeArtifactV1_3(dat_re,F0Lst(2),5,1);
dat_re=removeArtifactV1_3(dat_re,F0Lst(3),5,2);
dat_re=removeArtifactV1_3(dat_re,F0Lst(5),21,1);

%% show result
dat_re_mean=squeeze(mean(dat_re,[1 2]));
EdgeEffect=ceil(1000);
figure;
[P1_re,~,~]=FFTparameter(dat_re_mean(EdgeEffect:end-EdgeEffect),1);
[P1,f,~]=FFTparameter(dat_mean(EdgeEffect:end-EdgeEffect),1);
plot(f,P1);
hold on;
plot(f,P1_re);
[~,I]=min(abs(f-F0));
ylim([0 5*P1(I)]);
legend("original","new");
%%
TimeWindows=round(5/F0);
PlotReconstructedSignal(dat_mean,dat_re_mean,TimeWindows,F0);