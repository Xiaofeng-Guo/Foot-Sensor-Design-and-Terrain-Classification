TSSeg_s=[300,300,200,1000,30];
NTSSeg_s=[600,50,200,1000,20];
TSSeg_d=10;

% TSSeg_s=[100,100,100,100,30];
% NTSSeg_s=[200,200,200,100,20];
% TSSeg_d=10;

% 
% TSSeg_s=[6,10,4,10,3];
% NTSSeg_s=[5,5,20,5,2];
% TSSeg_d=4;



global data;
data = load ('1Hap&Acc_pre.txt');
data_size=size(data);

global fhap;
global facc;
global terrain_type;
fhap = fopen('1Hap_Readabledata.txt','w');
facc = fopen('2Acceleration.txt','w'); 
terrain_type=7;
i=1;
stage_sum=0;
stage_sum2=0;
stage_sum3=0;
stage_flag=0;
stage_flag1=0;
temp_a=0;
de=0;
be=1;
en=1;
in = 0;
fl=0;
mm=zeros (1,20000);

% aaa=1;
% bbb=1980;
% for i=aaa:fix((bbb-aaa)/24):bbb
%     be=i;
%     en=min(i+70,data_size(1));
%     w2f(be,en);
% end

for iii= 1: data_size(1)
    su(i)=0;
    ma(i)=-100; 
	for temp_i=1:6
        su(i)=su(i)+data(i,temp_i);
        if data(i,temp_i)>ma(i)
            ma(i)=data(i,temp_i);
        end
    end
    de=su(i)-temp_a;
	temp_a=su(i);
    mm(i)=stage_flag;
    if (stage_flag==0)
        if ((su(i)>TSSeg_s(1))||(ma(i)>NTSSeg_s(1)))
            if (ma(i)>NTSSeg_s(1)&&(su(i)<TSSeg_s(1)))
                stage_flag1=1;
            end
            stage_sum=stage_sum+1;	
            if stage_sum>=1
                stage_flag=1;
                stage_sum=0;
            end
        else
            stage_sum=0;
        end
    end
	if (stage_flag==1)
        if (((stage_flag1==0)&&su(i)<TSSeg_s(2))||((stage_flag1==1)&&(ma(i)<NTSSeg_s(2))))
	   		stage_sum=stage_sum+1;	
	   		if ((stage_sum>=10)||(i==data_size(1)))
	   			stage_flag=2;
	   			stage_sum=0;
            end
		else
			stage_sum=0;
        end
    end
	if (stage_flag==2)
		if ((su(i)>TSSeg_s(4))||(ma(i)>NTSSeg_s(4)))
			stage_sum2=stage_sum2+1;
			if (stage_sum2>=5)
				stage_sum=0;
				en=i-stage_sum2;
				if ((en-be)<10)
                    i=i+1;
                    continue;
                end
				w2f(be,en);
				in=0;
				stage_flag1=0;
				stage_sum2=0;
				stage_sum3=0;
                be=i-stage_sum2-6;
    			stage_flag=0;
        		if ((su(i)>TSSeg_s(1))||(ma(i)>NTSSeg_s(1)))
	   				if (ma(i)>NTSSeg_s(1))
	   					stage_flag1=1;
                    end;
				   	stage_sum=stage_sum+1;	
			   		if (stage_sum>=1)
			   			stage_flag=1;
			   			stage_sum=0;
                    end
                else
                    stage_sum=0;
                end;
				i=i+1; 
				continue;
            end
        else
			stage_sum2=0;
        end
		if abs(su(i))<TSSeg_s(3)&&de<TSSeg_d
            stage_sum=stage_sum+1;
	   		if (stage_sum>=5||iii==data_size(1))
                stage_sum=0;
				en=min(i+2,data_size(1));
				if ((en-be)<10)
					i=i+1;
                    continue;
                end
       			w2f(be,en);
                in=0;
                stage_flag1=0;
	   			be=i-3;
	   			stage_sum2=0;
	   			stage_sum3=0;
                i=i+1;
	   			stage_flag=0;
	   			continue;
            end
        else
               stage_sum=0;
        end
    end
	if ((su(i)<TSSeg_s(5))&&(ma(i)<NTSSeg_s(5)))
       	stage_sum3=stage_sum3+1;
	else
		stage_sum3=0;   	
    end
	if (stage_sum3>20&&(i-be)>=30&&stage_flag==0&&stage_sum==0)
      	be=i-10;
       	stage_sum3=0;
    end
    i=i+1;
	in=in+1;
end
fprintf (fhap,'\n\n\n\n\n');
fclose (fhap);
fprintf (facc,'\n\n\n\n\n');
fclose (facc);


function [] = w2f(be, en)
    global fhap;
        global facc;
    global terrain_type;
    global data;
    a=1
    %fhap = fopen('2Readabledata.txt','w'); 
	fprintf (fhap,'%d ',terrain_type);
    fprintf (fhap,'%d ',en-be+1);
	for i=be:en
        for i1=1:6
            fprintf (fhap,'%f ',data(i,i1));
        end
    end
	fprintf (fhap,'\n');
    
    
    
	fprintf (facc,'%d ',terrain_type);
    fprintf (facc,'%d ',en-be+1);
	for i=be:en
        for i1=1:3
            fprintf (facc,'%f ',data(i,i1+6));
        end
    end
	fprintf (facc,'\n');
    
end