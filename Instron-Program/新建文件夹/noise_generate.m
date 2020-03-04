clear;

fhap = fopen('Hap_noise_data.txt','w');
facc = fopen('Acceleration_noise.txt','w'); 
faco=fopen('Audio_noise.txt','w');
fcap=fopen('Capacitive_noise.txt','w');
for i=1:5000
    i
    fprintf (fhap,'%d ',1);
    fprintf (fhap,'%d ',900);
    for j=1:6
        hap=zeros(1,900);
            fprintf (fhap,'%.6f ',hap);
    end
    fprintf (fhap,'\n');
    
    
     fprintf (facc,'%d ',1);
    fprintf (facc,'%d ',90);
    for j=1:3
        acc=zeros(1,90);
            fprintf (facc,'%.6f ',acc);
    end
    fprintf (facc,'\n');
    
    
    fprintf (faco,'%d ',1);
    fprintf (faco,'%d ',22000);
    fprintf (faco,'%d ',16384);
        aco=0.02*zeros(1,16384);
            fprintf (faco,'%.6f ',aco);
    fprintf (faco,'\n');
    
    
    
    fprintf (fcap,'%d ',1);
    fprintf (fcap,'%d ',14000);
    cap=3.6+abs(0.02*zeros(1,14000));
            fprintf (fcap,'%.6f ',cap);
    fprintf (fcap,'\n');
    
end
    fprintf (fhap,'%d',-1);
    fclose(fhap);
        fprintf (facc,'%d',-1);
    fclose(facc);
        fprintf (faco,'%d',-1);
    fclose(faco);
        fprintf (fcap,'%d',-1);
    fclose(fcap);