function PlotReconstructedSignal(y_org,y_re,timeWindow,F0)
figure;
ax4=subplot(2,2,1);
plot(y_org,'linewidth',1);
hold on;
plot(y_re,'linewidth',1);
title("the reconstructed signal");
legend("original signal","reconstructed signal");

SampleUint=timeWindow;
stepUint=1;
paddingSize=SampleUint;
F0Idx=floor((timeWindow-1)*F0)+1;


TimeResolution=max(SampleUint,paddingSize);
MinFreq=round(TimeResolution/40);
MaxFreq=round(TimeResolution/2);

SpectrumAlongTime=getSpectrumTime(y_re,paddingSize,SampleUint,stepUint);
SpectrumAlongTime_org=getSpectrumTime(y_org,paddingSize,SampleUint,stepUint);
SpectrumAlongTime_their=SpectrumAlongTime_org-SpectrumAlongTime;

maxValue=max(SpectrumAlongTime_org(F0Idx:end,:),[],'all');

ax1=subplot(2,2,2);
imagesc(SpectrumAlongTime_org(1:MaxFreq,:));
title("original spectrum")
xlim([1 length(y_org)]);
caxis([0 maxValue]);

ax2=subplot(2,2,3);
imagesc(SpectrumAlongTime(1:MaxFreq,:));
title("new spectrum")
caxis([0 maxValue]);

ax3=subplot(2,2,4);
imagesc(SpectrumAlongTime_their(1:MaxFreq,:));
title("difference spectrum")
caxis([0 maxValue]);

linkaxes([ax1,ax2,ax3,ax4],'x');
linkaxes([ax1,ax2,ax3],'xy');
end