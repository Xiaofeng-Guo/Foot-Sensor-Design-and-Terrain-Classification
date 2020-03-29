clear;

haptic_feature = load ('Hap_feature.txt','r');
haptic_label = load ('Hap_label.txt','r');
hap_label_size = size (haptic_label);
acoustic_feature = load ('Acoustic_feature.txt','r');
acoustic_label = load ('Acoustic_label.txt','r');
aco_label_size = size (acoustic_label);

capacitive_feature = load ('Capacitive_feature.txt','r');
capacitive_label = load ('Capacitive_label.txt','r');
cap_label_size = size (capacitive_label);

accleration_feature = load ('Acceleration_feature.txt','r');
accleration_label = load ('Acceleration_label.txt','r');
acc_label_size = size (accleration_label);




i=0;
hap_i=0;
aco_i=0;
cap_i=0;
acc_i=0;
c_label = haptic_label (1);
while 1
   hap_i=hap_i+1;
   aco_i=aco_i+1;
   cap_i=cap_i+1;
   acc_i=acc_i+1;
   if (hap_i>hap_label_size(1)||aco_i>aco_label_size(1)||cap_i>cap_label_size(1)||acc_i>acc_label_size(1))
       break;
   end
   i=i+1
   if (haptic_label(hap_i)==acoustic_label(aco_i)&&acoustic_label(aco_i)==capacitive_label(cap_i)&&acoustic_label(aco_i)==accleration_label(acc_i))
       label(i)=haptic_label(hap_i);
       c_label = haptic_label(hap_i);
       feature (i,:)=[haptic_feature(hap_i,:),acoustic_feature(aco_i,:),capacitive_feature(cap_i,:),accleration_feature(acc_i,:)];
   else
       c_label
       if (haptic_label(hap_i)~=c_label&&acoustic_label(aco_i)~=c_label&&capacitive_label(cap_i)~=c_label&&accleration_label(acc_i)~=c_label)
            c_label=haptic_label(hap_i)
       end
       if haptic_label(hap_i)~=c_label
           while 1  
               if acoustic_label(aco_i)==haptic_label(hap_i)
                   break;
               end
               aco_i=aco_i+1
           end
           while 1  
               if capacitive_label(cap_i)==haptic_label(hap_i)
                   break;
               end
               cap_i=cap_i+1
           end
           while 1  
               if accleration_label(acc_i)==haptic_label(hap_i)
                   break;
               end
               acc_i=acc_i+1
           end
       elseif accleration_label(acc_i)~=c_label
           while 1  
               if haptic_label(hap_i)==accleration_label(acc_i)
                   break;
               end
               hap_i=hap_i+1
           end
           while 1  
               if capacitive_label(cap_i)==accleration_label(acc_i)
                   break;
               end
                cap_i=cap_i+1
           end
           while 1  
               if acoustic_label(aco_i)==accleration_label(acc_i)
                   break;
               end
               aco_i=aco_i+1
           end
       elseif acoustic_label(aco_i)~=c_label
           while 1  
               if haptic_label(hap_i)==acoustic_label(aco_i)
                   break;
               end
               hap_i=hap_i+1
           end
           while 1  
               if capacitive_label(cap_i)==acoustic_label(aco_i)
                   break;
               end
                cap_i=cap_i+1
           end
           while 1  
               if accleration_label(acc_i)==acoustic_label(aco_i)
                   break;
               end
               acc_i=acc_i+1
           end
       end
       label(i)=haptic_label(hap_i);
       c_label = haptic_label(hap_i);
       feature (i,:)=[haptic_feature(hap_i,:),acoustic_feature(aco_i,:),capacitive_feature(cap_i,:),accleration_feature(acc_i,:)];
   end

end
label_size=i;
label=label';



ffea = fopen ('All_feature.txt','w');
fla = fopen ('All_label.txt','w');
for i=1:label_size
    fprintf (ffea,'%f ',feature(i,:));
    fprintf (ffea,'\n');
      fprintf (fla,'%d',label(i));
    fprintf (fla,'\n');
    
end
