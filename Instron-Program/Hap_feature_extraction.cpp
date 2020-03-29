#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#define MAXN 0x7fff
#define MAXM 0X7fff
#define infinity 0x7fff
int N;
int M;
int Y[MAXN];
int t[MAXN];
int SI;
double s[MAXM];
double sum[MAXM];
double mon[10][100];			// mean:mon[1]; varience: mon[2];
double variance[MAXN];
double skewness[10];
double kurtosis[10];
double d[1000][1000];
double dist[1000][1000];
double max_indi[6];
double max_sum=0;
double min_sum=0;
int peak_time=0;
int minus_peak_time=0;
void read_data()
{	
}


FILE *fdata= fopen ("Hap_data.txt","r");
FILE *ffeature = fopen ("Hap_feature.txt","w");
FILE *flabel= fopen ("Hap_label.txt","w"); 


/*
0:		peak value of sum			//it seems this one is useless
1~6:	peak value of sensor 1~6		
7:		ascend time (the time between 20%-80% peak; )
8-13:		force distribution at the peak time	for 6 sensors
14-19:		mean for 6 sensors
20-25:		variance for 6 sensors
26-31:		skewness for 6 sensors
32-37:		kurtosis for 6 sensors


ToDo:
Use PCA to choose which features are really useful

*/

double pow (double a, int n)
{	double ans=1;
	for (int i1=0;i1<n;i1++)
	{	ans*=a;
	}
	return ans;
}


void prepro()
{	memset (sum,0,sizeof (sum));
	int i2=-1;
	for (int i1=0;i1<t[SI]*6;i1++)
	{
		if ((i1%6)==0)
		{	i2++;
		}
		if((i1%6)!=4) 
		{	sum[i2]+=s[i1];
		}
	}
	double al_sum=0;
	for (int i1=0;i1<6;i1++)
	{	al_sum=0;
		for (int i2=0;i2<t[SI];i2++)
		{	al_sum+=s[i2*6+i1];
		}
		mon[1] [i1]=al_sum/t[SI];
	}
	
	for (int i3=2;i3<=4;i3++)
	{	for (int i1=0;i1<6;i1++)
		{	al_sum=0;
			for (int i2=0;i2<t[SI];i2++)
			{	al_sum+=pow(s[i2*6+i1]-mon[1][i1],i3);
			}
			mon[i3] [i1]=al_sum/t[SI];
		}
	}
	for (int i1=0;i1<6;i1++)
	{	skewness[i1]=mon[3][i1]/sqrt(pow(mon[2][i1],3));
	}
	
	for (int i1=0;i1<6;i1++)
	{	kurtosis[i1]=mon[4][i1]/(pow(mon[2][i1],2));
	}
	
	
}






void sum_peak_value()
{	max_sum=-100;
	peak_time=0;
	for (int i1=0;i1<t[SI];i1++)
	{	//fprintf (ffeature,"%f ",sum[i1]);
		if (sum[i1]>max_sum)
		{	max_sum=sum[i1];
			peak_time=i1;
		}
	}
	
	//fprintf (ffeature,"%-20f",(max_sum));
	fprintf (ffeature,"%-20f",(max_sum-500)/500);
}

void indivual_peak_value()
{	for (int i1=0;i1<6;i1++)
	{	max_indi[i1]=-100;
	}
	for (int i1=0;i1<t[SI]*6;i1++)
	{	if (s[i1]>max_indi[i1%6])
		{	max_indi[i1%6]=s[i1];
		}
	}
	for (int i1=0;i1<6;i1++)
	{	if (i1==4)
		{	//continue;
		}
		fprintf (ffeature, "%-20f",(max_indi[i1]-100)/100);
	}
}


void ascend_time()
{	double begin_thr=((max_sum*0.1)<50? 50:max_sum*0.1);
	double end_thr=max_sum*0.9;
	double be=0,en=t[SI]-1;
	int befl=0,enfl=0;
	for (int i1=0;i1<t[SI];i1++)
	{	if (befl==0&&sum[i1]>begin_thr)
		{	be=i1;
			befl=1;
		}
		if (enfl==0&&sum[i1]>end_thr)
		{	en=i1;
			enfl=1;
			break;
		}
	}
	fprintf (ffeature,"%-20f",((en-be+1)-10)/10);
}


void discend_time()
{	double begin_thr=max_sum*0.8;
	double end_thr=max_sum*0.01;
	double be=0,en=t[SI]-1;
	int befl=0,enfl=0;
	for (int i1=peak_time;i1<t[SI];i1++)
	{	if (befl==0&&sum[i1]<begin_thr)
		{	be=i1;
			befl=1;
		}
		if (enfl==0&&sum[i1]<end_thr)
		{	en=i1;
			enfl=1;
			break;
		}
	}
	fprintf (ffeature,"%-20f",en-be+1);
}



void F_dis_peak()
{	for (int i1=0;i1<6;i1++)
	{	if (i1==4)
		{	//continue;
		}
		fprintf (ffeature, "%-20f",(s[peak_time*6+i1]-100)/100);
	}
}



void minus_sum_peak_value()
{	min_sum=100;
	minus_peak_time=0;
	for (int i1=0;i1<t[SI];i1++)
	{	//fprintf (ffeature,"%f ",sum[i1]);
		if (sum[i1]<min_sum)
		{	min_sum=sum[i1];
			minus_peak_time=i1;
		}
	}
	fprintf (ffeature,"%-20f",(min_sum+50)/50);
}


void minus_indivual_peak_value()
{	double min_indi[6]={100,100,100,100,100,100};
	for (int i1=0;i1<t[SI]*6;i1++)
	{	if (s[i1]<min_indi[i1%6])
		{	min_indi[i1%6]=s[i1];
		}
	}
	for (int i1=0;i1<6;i1++)
	{	if (i1==4)
		{	//continue;
		}
		fprintf (ffeature, "%-20f",(min_indi[i1]+20)/20);
	}
}





int min (int a,int b)
{	return a<b? a:b;
}

double dtw (double *p, int np, double *q, int nq)
{	memset (d,0,sizeof (d[0][0]));
    for (int k1=1;k1<=np;k1++)
    {	for (int k2=1;k2<=nq;k2++)
		{	d[k1][k2]=abs(p[k1-1]-q[k2-1]);
		}
	}	
	memset (dist,infinity,sizeof (dist[0][0]));
	dist[0][0]=d[0][0]*d[0][0];
   	for (int i=1;i<=np;i++)
   	{  for (int j=1;j<=nq;j++)
      	{  dist[i][j]=min(dist[i-1][j-1]+2*d[i][j],min(dist[i-1][j]+d[i][j],dist[i][j-1]+d[i][j]));
      	}
   	}
	return dist[np][nq];  
}



void distribution()
{
} 


void difference()
{	double ans=0;
	int c1,c2;
	for (int i1=0;i1<5;i1++)
	{	
		c1=i1;
		if (c1==4)
		{	continue;
		}
		c2=i1+1;
		if (c2==4)
		{	c2=c2+1;
		}
		ans=0;
		for (int i2=0;i2<t[SI];i2++)
		{	ans+=(s[i2*6+c1]-s[i2*6+c2]*(max_indi[c1]/max_indi[c2]))*(s[i2*6+c1]-s[i2*6+c2]*(max_indi[c1]/max_indi[c2])); 
		}
		ans=ans/t[SI]/(max_indi[c1]<0? -max_indi[c1]:max_indi[c1]);
		fprintf (ffeature, "%-20f",ans);
	}
}



void Feature_Exact()
{	

	prepro();
	sum_peak_value();		//1 
	indivual_peak_value();		//6 
	ascend_time();				//1 
	F_dis_peak();				//6 
	minus_sum_peak_value();		//1 
	minus_indivual_peak_value();		//6 
	
	for (int i1=0;i1<6;i1++)
	{	if (i1==4)
		{	//continue;
		}
		fprintf (ffeature, "%-20f",(mon[1][i1]-30)/30);
	}			//6 
	
	for (int i1=0;i1<6;i1++)
	{	if (i1==4)
		{	//continue;
		}
		fprintf (ffeature, "%-20f",(mon[2][i1]-2000)/2000);
	}		//6
	
	for (int i1=0;i1<6;i1++)
	{	if (i1==4)
		{	//continue;
		}
		fprintf (ffeature, "%-20f",(skewness[i1]));
	}		//6
	for (int i1=0;i1<6;i1++)
	{	if (i1==4)
		{	//continue;
		}
		fprintf (ffeature, "%-20f",kurtosis[i1]/5);
	}			//6
	//difference();
	fprintf (ffeature,"\n");
}

int main ()
{	SI=0;
	while (1)
	{	fscanf(fdata,"%d",&Y[SI]);
		if (Y[SI]==-1)
		{	break;
		}
		fscanf(fdata,"%d",&t[SI]);
		fprintf (flabel,"%d\n",Y[SI]);
		memset (s,0,sizeof (s));
		for (int i1=0;i1<t[SI]*6;i1++)
		{	fscanf (fdata,"%lf",&s[i1]);
		}
		Feature_Exact();
		SI++;
	}
	return  0;
}
