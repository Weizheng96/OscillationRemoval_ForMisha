function FundamentalFreq=findFundamentalFrequency(y_org,HighPassFilter_CircleLengthByPoint,LowPassFilter_CircleLengthByPoint)
%% find fundamental frequency
L=length(y_org);
paddingSize=L;

y_withPadding=zeros(1,paddingSize);
y_withPadding(1:L)=y_org;
P2=fft(y_withPadding);
if mod(paddingSize,2)==1
    P1=P2(1:(paddingSize-1)/2);
    P1(2:end)=2*P1(2:end);
else
    P1=P2(1:(paddingSize)/2+1);
    P1(2:end-1)=2*P1(2:end-1);
end
P1_abs=abs(P1);
LowFs=round((paddingSize-1)/HighPassFilter_CircleLengthByPoint);
HighFs=round((paddingSize-1)/LowPassFilter_CircleLengthByPoint);
P1_abs_highPass=P1_abs;
P1_abs_highPass(1:LowFs)=0;
P1_abs_highPass(HighFs:end)=0;

[~,idxOfFundamentalFreq]=max(P1_abs_highPass);
FundamentalFreq=idxOfFundamentalFreq/(paddingSize-1);
end