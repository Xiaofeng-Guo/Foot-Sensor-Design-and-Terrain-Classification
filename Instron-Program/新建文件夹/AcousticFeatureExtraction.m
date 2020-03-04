clc;clear;


audio_data = fopen('Audio_data.txt','r');
%haptic = load('haptic_feature_tmp.txt');

i=0;
while 1
    temp= fscanf (audio_data,'%d',1);
    if temp == -1
        break;
    end
        i=i+1;
    label (i) = temp;
    Fs(i) = fscanf (audio_data,'%d',1);
    n = fscanf (audio_data,'%d',1);

    data{i}=fscanf (audio_data,'%f',n);

end
num_data = i;
 for j=1:num_data
    p=data{j};
    ll=0;
    for i=2:length(p)
        if sign(p(i-1))~=sign(p(i))
            ll=ll+1;
        end
    end
    zcr(j)=length(p)/ll;
 end

 fe=zcr;
 
for j=1:num_data
    p=data{j};
    v(j)= var (p);
    m(j)=mean(p);
    ee(j)=-v(j)*log2(v(j)); 
end

%fe = [fe;ee];
for j=1:num_data
    p=data{j};
    temp=fftshift (abs(fft(p,65536)));
    ft{j} = temp(floor(length(temp)/2)+1:end);
    temp_ft=ft{j};
    
    k1=8192/4;
    k2=k1*2;
    for t=1:k1:18001-k2
        eb(j,floor(t/k1)+1)=0;
        for t2=0:k2
            eb(j,floor(t/k1)+1)=eb(j,floor(t/k1)+1)+temp_ft(t+t2);    
        end
         eb(j,floor(t/k1)+1)= eb(j,floor(t/k1)+1)/k2;
    end
    pt {j}= ft{j}.*ft{j};
end

fe = [fe;eb'];
fe = fe';
label = label';

%size_feature = size (haptic);
size_ac = size (fe);
fe = fe(1:size_ac,:);
%fe = [fe';haptic(1:min(size_feature,size_ac),:)']';

ffea = fopen ('Acoustic_feature.txt','w');
fla = fopen ('Acoustic_label.txt','w');
for i=1:size_ac
    fprintf (ffea,'%f ',fe(i,:));
    a=i
    fprintf (ffea,'\n');
    
      fprintf (fla,'%d',label(i));
    fprintf (fla,'\n');
    
end




% for i=1:num_data
%     fe2(:,i)=ft{i};
% end
% fe2=fe2';
