#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int m;
int t=10;

double ori[10][1000];
double sam[10][10000];
double temp_d;
double temp_i;
int l;
int n;
int main ()
{	
   	freopen ("1Hap_Readabledata.txt","r",stdin);
	freopen ("1Hap_Readabledata_in.txt","w",stdout);
	scanf ("%d",&m);
	//printf ("%d\n",m);
	memset (ori,0,sizeof (ori));
	memset (sam,0,sizeof (sam));
	for (int i1=0;i1<m;i1++)
	{	scanf ("%d",&l);
		printf ("%d ",l);
		scanf ("%d",&n);
		printf ("%d ",(n-1)*t+1);
		for (int i2=0;i2<6*n;i2++)
		{	scanf ("%lf",&ori[i2%6][i2/6]);
		}
		for (int i2=0;i2<6;i2++)
		{	for (int i3=0;i3<n-1;i3++)
			{	sam[i2][i3*t]=ori[i2][i3];
				temp_d=ori[i2][i3+1]-ori[i2][i3];
				temp_i=temp_d/(t);
				for (int i4=1;i4<t;i4++)
				{	sam[i2][i3*t+i4]=ori[i2][i3]+temp_i*i4;
				}
			}
			sam[i2][(n-1)*t]=ori[i2][n-1];
		}
		for (int i2=0;i2<(n-1)*t+1;i2++)
		{	for (int i3=0;i3<6;i3++)
			{	printf ("%lf ",sam[i3][i2]);
			}	
		}	
		printf ("\n");
	}

		printf ("\n\n\n\n\n");
	return 0;
}
