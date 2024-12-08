[y,fs]=audioread('Your Music Location');
%%
bpm=114; %Beats Per Minutes， for Erica:114
ppb=round(fs*60/bpm); %Points Per Beats
halfbeat=round(ppb/2);

% Shift Half Beats, making emphasis to be the center of a beat
yz=y(halfbeat+1:end-halfbeat,:);

yi0=yz(:,1);
yq0=yz(:,2);

% Calculate Num of Beats, integer
beats=floor(length(yi0)/ppb);

yi=yi0(1:ppb*beats);
yq=yq0(1:ppb*beats);

yi1=reshape(yi,ppb,[]);
yq1=reshape(yq,ppb,[]);

y1=complex(yi1,yq1);

% Calculate the Power of each Beats
zamp=sum(abs(y1),1);

figure;
stem(zamp)

%%
% Mask out Beats which power is small
ampmask=zamp>2400;  % 2400 is observed through zsamp
zamp1=zamp.*ampmask;

ztempI=find(zamp1~=0);
ztemp=zamp1(ztempI);
ampmax=max(ztemp);
ampmin=min(ztemp);

% Create UINT8 mapping table
space=(ampmax-ampmin)/(2^8);

thres=(0:255)*space+ampmin;

% Mapping each power into UINT8
cpr=zeros(1,length(zamp1));
for m=1:length(zamp1)
    cpr(m)=sum(zamp1(m)>=thres);
    if(cpr(m)>255), cpr(m)=cpr(m)-1; end
end

% Calculate beat duration
fs1=fs/ppb;
ts=1/fs1;

%%
s=serialport("COM5",9600);
%%
sound(y,fs);
flush(s);

a=uint8(cpr);
charlen=zeros(1,length(a));
r=zeros(1,length(a));

write(s,0,"uint8");
pause(ts/2); % First Half Beat

for m=1:length(a)
    
    charlen(m)=length(num2str(a(m)));
    a2=a(m);

    write(s,a2,"uint8");
    
    pause(ts);
    
end
