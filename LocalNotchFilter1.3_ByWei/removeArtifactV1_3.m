function dat_re=removeArtifactV1_3(dat_re,F0,FilterWindowsSize,Peak_num)

[~,~,L]=size(dat_re);
timeWindow=round(FilterWindowsSize/F0);
if mod(FilterWindowsSize,2)==0||FilterWindowsSize<5
    F0=FilterWindowsSize/timeWindow;
end
for harmonicPeakCnt=1:Peak_num
    harmonicFreq=F0*harmonicPeakCnt;
    y_sin=reshape(sin((1:L)*2*pi*harmonicFreq),1,1,L);
    y_cos=reshape(cos((1:L)*2*pi*harmonicFreq),1,1,L);
    y_sin_amp_p=dat_re.*y_sin;
    y_sin_amp=movmean(y_sin_amp_p,timeWindow,3)*2;
    clear("y_sin_amp_p");
    y_cos_amp_p=dat_re.*y_cos;
    y_cos_amp=movmean(y_cos_amp_p,timeWindow,3)*2;
    clear("y_cos_amp_p");
    dat_re=dat_re-y_sin_amp.*y_sin;
    dat_re=dat_re-y_cos_amp.*y_cos;
end

end