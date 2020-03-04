clc;clear;
load ('terrain07_group1_duration0p5s_5.mat');
hap_data = data(:,12:17);
cal = zeros(1,6);
for i=1:10
    cal=cal+hap_data(i,:);
end
cal =cal/10;
[time,useless] = size (hap_data);
for i=1:time
    for j=1:6
        hap_data(i,j) = cal(j)-hap_data(i,j);
    end
end

figure (1);
hold on;
plot (hap_data(:,1));
plot (hap_data(:,2));
plot (hap_data(:,3));
plot (hap_data(:,4));
plot (hap_data(:,5));
plot (hap_data(:,6));

for j=1:6
    sum=hap_data(:,j);
    size_sum=size(sum);
    d=zeros(size_sum(1)-1,1);
    for i=2: size_sum(1)
        d(i-1)=sum(i)-sum(i-1);
    end
    k=1;
    for t=201:200:size_sum(1)+200
        k=1;
        avr=0;
        avrs=0;
    for i=fix(t/200):min(t,size_sum(1)-1)
        avrs=avrs+sum(i);
        avr=avrs/(i-fix(t/200));
        if  (abs(sum(i)<10))%&&(sum(i)>-50-0.01*i)
            trendy (k)=sum(i);
            trendx(k)=i;
            k=k+1;
        end
    end
     P = polyfit(trendx(1:k-1),trendy(1:k-1),1 );
    for i=fix(t/200):min(t,size_sum(1))
        new_sum(i,j)=sum(i)-i*P(1)-P(2);
    end
    end
%     hold on;
    %plot (d);
%     subplot(1,2,1);
%     plot (sum);

    %plot(trendx,trendy);
%     P = polyfit(trendx,trendy,1 );
%     for i=1: size_sum(1)
%         new_sum(i,j)=sum(i);%-i*P(1)-P(2);
%     end
%     subplot(1,2,2);
%     plot(new_sum(:,j));
end
sum=hap_data(:,1)+hap_data(:,2)+hap_data(:,3)+hap_data(:,4)+hap_data(:,5)+hap_data(:,6);
Nsum=new_sum(:,1)+new_sum(:,2)+new_sum(:,3)+new_sum(:,4)+new_sum(:,5)+new_sum(:,6);
% subplot(1,2,1);
% plot (sum);
% subplot(1,2,2);
%plot(Nsum);
figure (2);
hold on;
plot (new_sum(:,1));
plot (new_sum(:,2));
plot (new_sum(:,3));
plot (new_sum(:,4));
plot (new_sum(:,5));
plot (new_sum(:,6));
plot (Nsum);
fid = fopen('1toReadableinput.txt','w');
for i=1:size_sum(1)
    for j=1:6
        fprintf (fid,'%f ',new_sum(i,j));
    end
    fprintf (fid,'\n');
end

fclose (fid);
