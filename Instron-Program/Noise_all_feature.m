clear;

haptic_feature = load ('Noise_Hap_feature.txt','r');
acoustic_feature = load ('Noise_Acoustic_feature.txt','r');
capacitive_feature = load ('Noise_Capacitive_feature.txt','r');
accleration_feature = load ('Noise_Acceleration_feature.txt','r');
feature=[haptic_feature,acoustic_feature,capacitive_feature,accleration_feature];
f_size=size(feature);
ffea = fopen ('Noise_All_feature.txt','w');

for i=1:f_size(1)
    fprintf (ffea,'%f ',feature(i,:));
    fprintf (ffea,'\n');
end
