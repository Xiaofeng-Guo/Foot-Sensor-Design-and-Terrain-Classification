%File name: Acceleration_Noise_Feature_Extraction
%Function describe: feature extraction for acceleration noise data
%Input file: Acceleration_noise
%       Each line represents one data point. 
%       For each line, terrain type(useless) + n + 3*n acceleration data. File ends with terrain type = -1
%Output file: Noise_Acceleration_feature
%       Each line represents m features of one data point. 



clc;clear;
facc = fopen('Acceleration_noise.txt','r');
i=0;
while 1
    temp= fscanf (facc,'%d',1);
    if temp == -1
        break;
    end
    i=i+1;
    label (i) = temp;
    n = fscanf (facc,'%d',1);
    data{i}=fscanf (facc,'%f',n*3);
    temp=data{i};
    acc_data{i}{1}=temp(1:3:end);
    acc_data{i}{2}=temp(2:3:end);
    acc_data{i}{3}=temp(3:3:end);
end

num_data = i;
fe=[];
for jj=1:3
 for j=1:num_data
    p=acc_data{j}{jj};
    ll=0;
    for i=2:length(p)
        d(i-1)=p(i)-p(i-1);
    end
    for i=2:length(p)-1
        if sign(d(i-1))~=sign(p(i))
            ll=ll+1;
        end
    end
    fe1(j)=length(p)/ll;
 end
 fe=[fe,fe1'];
end
 for jj=1:3
for j=1:num_data
    p=acc_data{j}{jj};
    s(j)=sum(p);
    v(j)= var (p);
    m(j)=mean(p);
    ma(j)=max(p);
    mi(j)=min(p);
end
fe = [fe,s',v',m',ma',mi'];
 end
% for j=1:num_data
%     p=data{j};
%     temp=fftshift (abs(fft(p,65536)));
%     ft{j} = temp(floor(length(temp)/2)+1:end);
%     temp_ft=ft{j};
%     
%     k1=8192/4;
%     k2=k1*2
%     for t=1:k1:30000-k2
%         eb(j,floor(t/k1)+1)=0;
%         for t2=0:k2
%             eb(j,floor(t/k1)+1)=eb(j,floor(t/k1)+1)+temp_ft(t+t2);    
%         end
%          eb(j,floor(t/k1)+1)= eb(j,floor(t/k1)+1)/k2;
%     end
%     pt {j}= ft{j}.*ft{j};
% end

% fe = [fe;eb'];
label = label';

%size_feature = size (haptic);
%fe = [fe';haptic(1:min(size_feature,size_ac),:)']';

ffea = fopen ('Noise_Acceleration_feature.txt','w');
for i=1:num_data
    fprintf (ffea,'%f ',fe(i,:));
    fprintf (ffea,'\n');
    
end
