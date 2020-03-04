clc;clear;
load ('terrain01_group1_duration0p5s_1.mat');
acc_data1 = data(:,18);
hold on;
plot (acc_data1);
load ('terrain07_group1_duration0p5s_1.mat');
acc_data2 = data(:,18);
plot (acc_data2);
fid = fopen('1toReadableinput.txt','w');
for i=1:size_sum(1)
    for j=1:6
        fprintf (fid,'%f ',new_sum(i,j));
    end
    fprintf (fid,'\n');
end

fclose (fid);
