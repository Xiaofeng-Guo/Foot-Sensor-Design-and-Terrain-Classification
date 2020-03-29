clc;clear;


capacitive_data = fopen('Capacitive_noise.txt','r');

i=0;
while 1
    temp= fscanf (capacitive_data,'%d',1);
    if temp == -1
        break;
    end
        i=i+1;
    label (i) = temp;
    n = fscanf (capacitive_data,'%d',1);

    data{i}=fscanf (capacitive_data,'%f',n);

end
num_data = i;

for j=1:num_data
    p=data{j};
    s(j)=sum(p);
    v(j)= var (p);
    m(j)=mean(p);
    ee(j)=-v(j)*log2(v(j)); 
end
fe = [v',m'];
for j=1:num_data
    p=data{j};
    temp=fftshift (abs(fft(p,65536)));
    ft{j} = temp(floor(length(temp)/2)+1:end);
    temp_ft=ft{j};    
    k1=8192/4;
    k2=k1*2;
    for t=1:k1:22001-k2
        eb(j,floor(t/k1)+1)=0;
        for t2=0:k2
            eb(j,floor(t/k1)+1)=eb(j,floor(t/k1)+1)+temp_ft(t+t2);    
        end
         eb(j,floor(t/k1)+1)= eb(j,floor(t/k1)+1)/k2;
    end
    pt {j}= ft{j}.*ft{j};
end

fe = [fe,eb];
label = label';

ffea = fopen ('Noise_Capacitive_feature.txt','w');
for i=1:num_data
    fprintf (ffea,'%f ',fe(i,:));
    fprintf (ffea,'\n');
    
   
end


