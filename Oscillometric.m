close all;
clear;
clc;
path = "..\03\";
files_name = dir(path);
sheet1 = "BloodPressureData";
sheet2 = "GasPressureData";
sheet3 = "CuffPressureData";
for i=6:6
    times = readcell(strcat(path, files_name(i).name),"Sheet",sheet1, "Range","A:A");
    bp = readcell(strcat(path, files_name(i).name),"Sheet",sheet1, "Range","B:B");
    % 1. 静息状态数据选择
    peaceStart = 70;
    peaceStop = 1000;
    peaceTimes = times(peaceStart:peaceStop,1);
    peacebp    = bp(peaceStart:peaceStop,1);
    peaceTimes = cell2mat(peaceTimes);
    peacebp = cell2mat(peacebp);
    % 平滑处理
    peacebp = smooth(peacebp)
    % 峰值计算
    [pks, locsPeak] = findpeaks(peacebp);
    % 谷值计算
    [valley, locsDown] = findpeaks(-peacebp);
    % 图像绘制
    figure(1)
    hold on
    plot(peaceTimes, peacebp)
    plot(peaceTimes(locsPeak), pks, '*')
    plot(peaceTimes(locsDown), -valley, 'o')
    hold off
    % 幅值计算
    i = 1;
    BPAmp = [];
    while(i < size(locsPeak, 1) / 2)
        BPAmp(i) = pks(2 * i - 1) + valley(2 * i - 1);
        i = i + 1;
    end 
    figure(2)
    plot(BPAmp, '*');

    % 2. 加压状态数据选择
    inflateStart = 5000;
    inflateStop = 6400;
    inflateTimes = times(inflateStart:inflateStop,1);
    inflatebp    = bp(inflateStart:inflateStop,1);
    inflateTimes = cell2mat(inflateTimes);
    inflatebp = cell2mat(inflatebp);
    % 平滑处理
    inflatebp = smooth(inflatebp)
    % 峰值计算
    [inflatepks, inflatelocsPeak] = findpeaks(inflatebp);
    % 谷值计算
    [inflatevalley, inflatelocsDown] = findpeaks(-inflatebp);
    % 图像绘制
    figure(3)
    hold on
    plot(inflateTimes, inflatebp)
    plot(inflateTimes(inflatelocsPeak), inflatepks, '*')
    plot(inflateTimes(inflatelocsDown), -inflatevalley, 'o')
    % 幅值计算
    i = 1;
    inflateBPAmp = [];
    while(i < size(inflatelocsPeak, 1) / 2)
        inflateBPAmp(i) = inflatepks(2 * i - 1) + inflatevalley(2 * i - 1);
        i = i + 1;
    end 
    figure(4)
    plot(inflateBPAmp, '*');
end