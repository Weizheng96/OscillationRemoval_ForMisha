function SpectrumAlongTime=getSpectrumTime(y,PadSize,SampleUint,stepUint)
%% along time
L=length(y);
for t=1
    step_idx_min=(t-1)*stepUint+1;
    step_idx_max=min(t*stepUint,L);
    
    step_idx_mid=round((step_idx_min+step_idx_max)/2);
    sample_idx_min=max(step_idx_mid-SampleUint,1);
    sample_idx_max=sample_idx_min+SampleUint-1;
    
    if sample_idx_max>L
        sample_idx_min=L-SampleUint+1;
        sample_idx_max=L;
    end
    
    time_sample=sample_idx_min:sample_idx_max;
    
    
    y_with_padding=zeros(PadSize,1);
    y_with_padding(1:length(time_sample))=y(time_sample);


    [P1,~,~]=FFTparameter(y_with_padding,1);
    if t==1
        SpectrumAlongTime=zeros(length(P1),ceil(L/stepUint));
    end

    SpectrumAlongTime(:,t)=P1;
end

for t=2:ceil(L/stepUint)
    step_idx_min=(t-1)*stepUint+1;
    step_idx_max=min(t*stepUint,L);
    
    step_idx_mid=round((step_idx_min+step_idx_max)/2);
    sample_idx_min=max(step_idx_mid-SampleUint,1);
    sample_idx_max=sample_idx_min+SampleUint-1;
    
    if sample_idx_max>L
        sample_idx_min=L-SampleUint+1;
        sample_idx_max=L;
    end
    
    time_sample=sample_idx_min:sample_idx_max;
    
    
    y_with_padding=zeros(PadSize,1);
    y_with_padding(1:length(time_sample))=y(time_sample);


    [P1,~,~]=FFTparameter(y_with_padding,1);

    SpectrumAlongTime(:,t)=P1;
end

% SpectrumAlongTime=imresize(SpectrumAlongTime,[max_HZ,size(SpectrumAlongTime,2)]);

end