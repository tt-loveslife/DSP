close all;
clear;
clc;
path = "..\03\";
files_name = dir(path);
sheet1 = "BloodPressureData";
sheet2 = "GasPressureData";
sheet3 = "CuffPressureData";
for i=10:10
    times = readcell(strcat(path, files_name(i).name),"Sheet",sheet1, "Range","A:A");
    bp = readcell(strcat(path, files_name(i).name),"Sheet",sheet1, "Range","B:B");
    % 1.静坐阶段
    peaceStart = 300;
    peaceStop = 4000;
    peaceTimes = times(peaceStart:peaceStop,1);
    peacebp    = bp(peaceStart:peaceStop,1);
    peaceTimes = cell2mat(peaceTimes);
    peacebp = cell2mat(peacebp);
    % 功率谱分析
    N = 256;
    wn=peacebp(:,1);  
    P=10*log10(abs(fft(wn).^2)/N);  
    f=(0:length(P)-1)/length(P);  
    figure(1)
    plot(f,P);grid  

    % 1024 点采样分析
    N = 1024;
    fs = 50;
    data = peacebp(1:N);
    n = 1:N;
    t = n / fs;
    figure(2)
    plot(t, data)

    % 傅里叶变换
    y = fft(data, N);
    mag = abs(y);
    f = n * fs / N;
    figure(3)
    plot(f, mag);
    xlabel('频率/Hz');
    ylabel('振幅');
    title('N = 256');
    grid on;

    % 巴特沃斯滤波器设计
    fp = [0.7 3.5];fs = [0.5 5];
    rp = 3; rs = 18;
    Fs = 30;
    wp = fp*2*pi/Fs; ws = fs*2*pi/Fs;
    [n, wn]=buttord(wp/pi, ws/pi, rp, rs);
    [b, a] = butter(n, wp / pi);
    [h, w] = freqz(b, a, 1024, Fs);
    figure(4)
    plot(w, abs(h));grid;
    xlabel('Hz');
    ylabel('Bandpass DF');

    % 滤波后结果
    nData = filter(b, a, data);
    nDataAbs = abs(fft(nData, 1024));
    figure(5); plot(f, nDataAbs);
    figure(6); plot(nData);

end