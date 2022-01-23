% Kbp
clc
clear

%% 数据读取
filename = 'E:\加压实验\1114\Sensor_BP1_1114002正常.xls';
sheet1 = 'BloodPressureData';
sheet2 = 'SPO2Data';
xlRange = 'A2:B1800';

A = xlsread(filename,sheet2,xlRange);
x = A(:,1);
y = A(:,2);

y_filted = y(800:1200);

%% 去基线 低通
d = y_filted;
fmaxd = 5;
fs = 1000;
fmaxn = fmaxd/(fs/2);
[b,a] = butter(1,fmaxn,'low');
dd = filtfilt(b,a,d);
cc = d-dd;

%step0 : minvalue
[maxv1,maxl1] = findpeaks(-cc,'minpeakdistance',19);
figure(2);
plot(cc);
hold on;
plot(maxl1,-maxv1,'*','color','r');

%step1 Kbp
n = length(maxl1);
k = zeros(n-1,1);
for i=1:n-1
    sy = y_filted(maxl1(i):maxl1(i+1));
    ps = max(sy);
    pm = mean(sy);
    pd = min(sy);
    k(i) = (pm-pd)/(ps-pd);
end

figure(3);
plot(k);
hold on;
xk = 1:1:n-1;
scatter(xk,k);
