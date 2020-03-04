clc;clear;
fid=fopen('Checkdata.txt','r');
k=0;
while ~feof(fid)
   a=fscanf (fid,'%d',1);
   n=fscanf (fid,'%d',1)
   data= fscanf (fid,'%f',n*6);
   clf;
   hold on;
   plot (data(1:6:end));
   plot (data(2:6:end));
   plot (data(3:6:end));
   plot (data(4:6:end));
   plot (data(5:6:end));
   plot (data(6:6:end));
   pause(0.4);
   k=k+1;
end
fscanf ('%d') 
size_data=size(data);

for i=1:size_data(1)
    n=data(i,2);
    hold on;
    plot(i,3:6:size_data(i,2));
end