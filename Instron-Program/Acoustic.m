clc;clear;
load ('terrain07_group3_duration0p5s_1.lvm');
label = 7;
fs1=22000;
Num=[-0.000311118476735336,0.00117464849830931,0.00144304897436479,-0.000296191258532085,-0.00204067673209557,-0.00118780621970690,0.000501913666103730,0.000173210409452585,5.14855364154363e-05,0.00303028375840465,0.00434859409697169,-0.00192727643564742,-0.00937067433847594,-0.00562463326593913,0.00663170670141666,0.0107225902455296,0.00157409368782132,-0.00656280838503625,-0.00398039957759261,0.000693137483986037,-0.000844534026837883,-0.00217158561677778,0.00248872023264825,0.00560520370682949,0.00133498821653268,-0.00280059023462308,-0.00110091158738904,-0.000374064970045310,-0.00416455755203054,-0.00370209713662424,0.00400345511287756,0.00746726225179131,0.00146161790053064,-0.00304388397374757,-0.000410020286596799,-0.000380516378949930,-0.00601422853322020,-0.00519500636947564,0.00470454822842662,0.00870535465656014,0.00173236674600542,-0.00228196968816348,0.00125312046332822,-0.000693120358720253,-0.00916075116866691,-0.00734507908958167,0.00583674122250333,0.0102838973261723,0.00187773970575444,-0.00109750624763679,0.00389204347272072,-0.000947213845145936,-0.0134321103359500,-0.0102713281949463,0.00708671372893963,0.0117892679269216,0.00181273098273702,0.00115753597387550,0.00833144058831388,-0.00120874803350767,-0.0197033694238836,-0.0144638635864951,0.00863486170814224,0.0131392704716123,0.00125263027807615,0.00533182696095164,0.0162355023752464,-0.00143164057068919,-0.0300284802541664,-0.0213132702136170,0.0109057760162776,0.0141982419463485,-0.000534684392320380,0.0142373392593170,0.0333069666432797,-0.00159822640175943,-0.0527648078095298,-0.0368825786336832,0.0161336982296911,0.0148782574165599,-0.00741683525967204,0.0454820261100927,0.101666484247000,-0.00168683487626026,-0.186389978535707,-0.165544990595033,0.0991651495287439,0.265104977256699,0.0991651495287439,-0.165544990595033,-0.186389978535707,-0.00168683487626026,0.101666484247000,0.0454820261100927,-0.00741683525967204,0.0148782574165599,0.0161336982296911,-0.0368825786336832,-0.0527648078095298,-0.00159822640175943,0.0333069666432797,0.0142373392593170,-0.000534684392320380,0.0141982419463485,0.0109057760162776,-0.0213132702136170,-0.0300284802541664,-0.00143164057068919,0.0162355023752464,0.00533182696095164,0.00125263027807615,0.0131392704716123,0.00863486170814224,-0.0144638635864951,-0.0197033694238836,-0.00120874803350767,0.00833144058831388,0.00115753597387550,0.00181273098273702,0.0117892679269216,0.00708671372893963,-0.0102713281949463,-0.0134321103359500,-0.000947213845145936,0.00389204347272072,-0.00109750624763679,0.00187773970575444,0.0102838973261723,0.00583674122250333,-0.00734507908958167,-0.00916075116866691,-0.000693120358720253,0.00125312046332822,-0.00228196968816348,0.00173236674600542,0.00870535465656014,0.00470454822842662,-0.00519500636947564,-0.00601422853322020,-0.000380516378949930,-0.000410020286596799,-0.00304388397374757,0.00146161790053064,0.00746726225179131,0.00400345511287756,-0.00370209713662424,-0.00416455755203054,-0.000374064970045310,-0.00110091158738904,-0.00280059023462308,0.00133498821653268,0.00560520370682949,0.00248872023264825,-0.00217158561677778,-0.000844534026837883,0.000693137483986037,-0.00398039957759261,-0.00656280838503625,0.00157409368782132,0.0107225902455296,0.00663170670141666,-0.00562463326593913,-0.00937067433847594,-0.00192727643564742,0.00434859409697169,0.00303028375840465,5.14855364154363e-05,0.000173210409452585,0.000501913666103730,-0.00118780621970690,-0.00204067673209557,-0.000296191258532085,0.00144304897436479,0.00117464849830931,-0.000311118476735336];
bbb=1;
acoustic_data = terrain07_group3_duration0p5s_1(:,2);
acoustic_data = acoustic_data(bbb:end);

size_acoustic = size (acoustic_data);
acoustic_data=filter (Num,1,acoustic_data);
plot (acoustic_data);
dd=0;
flag = 0;
be=1;
% for i=1:size_acoustic(1)
%     if abs(acoustic_data(i))>0.025
%         y1(be:i)=1;
%         be=i+1;
%         flag=1;
%         dd=0;
%     else
%         if flag==1
%             be = i;
%             flag = 0;
%         else
%             if dd>3000
%                 y1(be:i)=0;
%                 be=i+1;
%             else
%                 y1(be:i)=1;
%             end
%             dd=dd+1; 
%         end
%     end
% end
% flag=0;
% k=0;
% k2=0;
% be=1;
% en=1;
% data= zeros(100,200000);
% for i=1:size_acoustic(1)
%     if flag==0&&y1(i)==1
%         be=i;
%         flag=1;
% 
%         %seg2_data{k}=x1(en:be);
%     elseif flag==1&&y1(i)==0
%         en = i;
%         flag=0;
%         if ((en-be)>2000)
%             k=k+1;
%             en=en+8000;
%             seg_data1{k}=acoustic_data(be:en);
%         else
%             be=i+1;
%         end
% 
%         %data(k,1:en-be+1)=x1(be:en);
% %          figure (k);
% %          plot (data(k,:));
%         %sound (data(k,:),fs1);
%         %pause(3);
%     end
% end
% p = size(seg_data1);
% 
% for i=1:p(2)
%     a=seg_data1{i};
%     seg_data{i}=a(1:end);
%     seg_data{i}=filter (Num,1,seg_data{i});
% end


iii=1;
aa=input('aa=');
bb=input('bb=');
for i=aa:fix((bb-aa)/48):bb+fix((bb-aa)/48)
    seg_data{iii}=acoustic_data(i:i+fix((bb-aa)/48/1.3));
    iii=iii+1;
end
p = size(seg_data);
j=1;
% if mod (p(2),2)==1
%     j=2;
% else
%     j=1;
% end



file_audio_data = fopen('audio_data_tem.txt','w');

for kn=j:2:p(2)
audio_data= seg_data{kn};

noise = audio_data (1:end/2);
%noise = seg_data{max(kn-1,j+1)};
len_audio = length (audio_data);
len_noise = length (noise);

%if rem(len_audio,2) == 1, len_audio=len_audio+1; end;
PERC = 50;                          % window overlap in percent of frame size
len_audio1 = floor(len_audio*PERC/100);
len_audio2 = len_audio-len_audio1; 
 
Thres = 3;      % VAD threshold in dB SNRseg 
Expnt = 2;    % power exponent
beta = 0.002;
G = 0.9;
 
win_noise = hamming(len_noise);
winGain_noise = len_noise/sum(win_noise); % normalization gain for overlap+add with 50% overlap


win_audio = hamming(len_audio);
winGain_audio = len_audio/sum(win_audio); % normalization gain for overlap+add with 50% overlap



% Noise magnitude calculations - assuming that the first 5 frames is noise/silence
nFFT = 2^nextpow2(max(len_noise,len_audio));

noise_mu = abs(fft(noise',nFFT));
noise_an = angle (fft(noise',nFFT));
%plot (noise_mu);
%--- allocate memory and initialize various variables
k = 1;
img = sqrt(-1);
 
%=========================    Start Processing   ===============================
insign = audio_data';      % Windowing
spec = fft(insign,nFFT);         % compute fourier transform of a frame
sig = abs(spec);                 % compute the magnitude
    %save the noisy phase information 
theta = angle(spec);  
% SNRseg = 10*log10(norm(sig,2)^2/norm(noise_mu,2)^2);
% if Expnt == 1.0     % ·ù¶ÈÆ×
%     alpha = berouti1(SNRseg);
% else
%     alpha = berouti(SNRseg); % ¹¦ÂÊÆ×
% end
alpha =(mean(sig)/mean(noise_mu));
  %&&&&&&&&&
sub_speech = abs(sig.^Expnt - (alpha*noise_mu).^Expnt);
x_phase = (sub_speech.^(1/Expnt)).*(cos(theta)+img*(sin(theta)));
    % take the IFFT 
xi = real(ifft(x_phase));
 
fprintf (file_audio_data,'%d ',label);
fprintf (file_audio_data,'%d ',fs1);
fprintf (file_audio_data,'%d ',length(xi));
fprintf (file_audio_data,'%f ',xi);
fprintf (file_audio_data,'\n');
 
%    figure (kn);
%  plot (xi);
% 
%  plot (abs(x_phase));
%  sound (xi,fs1);
%   pause(3);
end

%fprintf (file_audio_data,'-1');
fprintf (file_audio_data,'\n');
fprintf (file_audio_data,'\n');
fprintf (file_audio_data,'\n');
fprintf (file_audio_data,'\n');
fprintf (file_audio_data,'\n');



fclose (file_audio_data);


function a = berouti(SNR)
    if SNR >= -5.0 & SNR <= 20
        a = 4-SNR*3/20; 
    else
        if SNR < -5.0
            a = 5;
        end
        if SNR > 20
            a = 1;
        end
    end
end
 
function a = berouti1(SNR)
if SNR >= -5.0 & SNR <= 20
	a = 3-SNR*2/20;
else
    if SNR < -5.0
        a = 4;
    end
    if SNR > 20
        a = 1;
	end
end
end
 
