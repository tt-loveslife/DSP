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
    % 加压阶段数据选择
    inflateStart = 3800;
    inflateStop = 4600;
    inflateTimes = times(inflateStart:inflateStop,1);
    inflateTimes = cell2mat(inflateTimes);
    inflatebpBefore = bp(inflateStart:inflateStop,1);
    inflatebpBefore = cell2mat(inflatebpBefore);
    inflatebp = inflatebpBefore;
    % 基线去除
    fmaxd = 5;
    fs = 1000;
    fmaxn = fmaxd/(fs/2);
    [b,a] = butter(1,fmaxn,'low');
    dd = filtfilt(b,a,inflatebp);
    inflatebp = inflatebp-dd;
    figure(1)
    hold on
    plot(inflateTimes(1:35), inflatebpBefore(1:35))
    plot(inflateTimes(150:182), inflatebpBefore(150:182))
    plot(inflateTimes(300:330), inflatebpBefore(300:330))
    plot(inflateTimes(450:480), inflatebpBefore(450:480))
    plot(inflateTimes(520:550), inflatebpBefore(520:550))
    plot(inflateTimes(590:620), inflatebpBefore(590:620))
    plot(inflateTimes(650:680), inflatebpBefore(650:680))
    plot(inflateTimes(720:750), inflatebpBefore(720:750))
    plot(inflateTimes, dd - 100);
    plot(inflateTimes, inflatebp);
    hold off
end