#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define MAXN 0x3fff












double sum[MAXN];
double input [MAXN][6];
double max[MAXN];
int terrain_type;
//int TSSeg_s[]={100,100,60,100,30};
//int NTSSeg_s[]={50,50,200,50,20};
int TSSeg_s[]={10,10,4,10,3};
int NTSSeg_s[]={5,5,20,5,2};
int TSSeg_d=10;




double abs(double a)
{  return a<0? -a:a;
}




void w2f (int begin, int end)
{	printf ("%d %d ",terrain_type,end-begin+1);
	
	for (int i=begin;i<=end;i++)
	{	for (int i1=0;i1<6;i1++)
		{	printf ("%lf ",input[i][i1]);
		}	
	}
	printf ("\n");
}





int main ()
{
	freopen ("1toReadableinput.txt","r",stdin);
   	freopen ("2Readabledata.txt","w",stdout);
    scanf ("%d",&terrain_type);
   	int i=0;
   	int stage_sum=0,stage_sum2=0,stage_sum3=0;
   	int stage_flag=0,stage_flag1=0;
   	int temp_a=0;
   	int de;
   	int begin=0,end=0;
   	int in = 0;
   	int fl=0;
   	while (1)
   	{	sum[i]=0;
   		max[i]=-100; 
	   	for (int temp_i=0;temp_i<6;temp_i++)
   		{	if (scanf ("%lf",&input[i][temp_i])==EOF)
   			{	fl=1;	
			   	break;
   			}
   			sum[i]+=input[i][temp_i];
   			if (input[i][temp_i]>max[i])
   			{	max[i]=input[i][temp_i];
   			}
		} 
		if (fl==1)
		{	break;
		}
		//printf ("%lf %lf\n",sum[i],max[i]);
		de=sum[i]-temp_a;
		temp_a=sum[i];
	//	printf ("%d\n",stage_flag);
	   	if (stage_flag==0)
	   	{  	if ((sum[i]>TSSeg_s[0])||(max[i]>NTSSeg_s[0]))
	   		{	if (max[i]>NTSSeg_s[0])
	   			{	stage_flag1=1;
	   			}
	   		//	printf ("aa");
			   	stage_sum++;	
		   		if (stage_sum>=1)
		   		{	stage_flag=1;
		   			stage_sum=0;
		   		}
		   	}
		   	else
		   	{	stage_sum=0;
		   	}
		}
	   	if (stage_flag==1)
	   	{  	if (((stage_flag1==0)&&sum[i]<TSSeg_s[1])||((stage_flag1==1)&&(max[i]<NTSSeg_s[1])))
	   		{	stage_sum++;	
	   			if (stage_sum>=10)
	   			{	stage_flag=2;
	   				stage_sum=0;
	   			}
			}
			else
			{	stage_sum=0;
			}
	   	}
	   	if (stage_flag==2)
	   	{	if ((sum[i]>TSSeg_s[3])||(max[i]>NTSSeg_s[3]))
			{	stage_sum2++;
				if (stage_sum2>=1)
				{	stage_sum=0;
					end=i-stage_sum2;
					if ((end-begin)<10)
				   	{i++;	
					   continue;
				   	}
					w2f(begin,end);
					in=0;
					stage_flag1=0;
					stage_sum2=0;
					stage_sum3=0;
					begin=i-stage_sum2-6;

					stage_flag=0;
			//		printf ("aa");
					if ((sum[i]>TSSeg_s[0])||(max[i]>NTSSeg_s[0]))
	   				{	if (max[i]>NTSSeg_s[0])
	   					{	stage_flag1=1;
	   					}
					   	stage_sum++;	
				   		if (stage_sum>=1)
				   		{	stage_flag=1;
				   			stage_sum=0;
				   		}
			//	   		printf ("bb");
				   	}
				   	else
				   	{	stage_sum=0;
				   	}
				   	i++; 
					continue;
				}
			}
			else
			{	stage_sum2=0;
			}
		    if (abs(sum[i])<TSSeg_s[2]&&de<TSSeg_d)
	   		{	stage_sum++;
	   			if (stage_sum>=5)
	   			{	stage_sum=0;
				   	end=i+2;
				   	if ((end-begin)<10)
				   	{	i++;continue;
				   	}
	   				w2f(begin,end);
	   				in=0;
	   				stage_flag1=0;
	   				begin=i-3;
	   				stage_sum2=0;
	   				stage_sum3=0;
	   				i++;
	   					//printf ("cc");
	   				stage_flag=0;
	   				continue;
	   			}
	   		}
	   		else
	   		{	stage_sum=0;
	   		}
	   	
			    
	  	}	
	   	
	   	i++;
	   	in++;
	   	if ((sum[i]<TSSeg_s[4])&&(max[i]<NTSSeg_s[4]))
	   	{	stage_sum3++;
	   	}
	   	else
	   	{	stage_sum3=0;
	   	}
	   	
	   	
	   	
		if (stage_sum3>20&&(i-begin)>=30&&stage_flag==0&&stage_sum==0)
        {	begin=i-10;
        	stage_sum3=0;
   		}
   	}
	printf ("\n");
		printf ("\n");
			printf ("\n");
  

  return 0;
}
