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
    % 1.静坐阶段
    peaceStart = 300;
    peaceStop = 8000;
%     peaceTimes = times(peaceStart:end,1);
%     peacebp    = bp(peaceStart:end,1);
    peaceTimes = times(peaceStart:peaceStop,1);
    peacebp    = bp(peaceStart:peaceStop,1);
    peaceTimes = cell2mat(peaceTimes);
    peacebp = cell2mat(peacebp);
    % 峰值计算
    [pks, locs] = findpeaks(peacebp,'MinPeakDistance',6,'MinPeakHeight', 0.90 * mean(peacebp(:)));
    % 谷值计算、KBP计算
    peaceValleyStart = 300;
    peaceValleyEnd = 600;
    peaceValleyBp = bp(peaceValleyStart:peaceValleyEnd,1);
    peaceValleyBp = cell2mat(peaceValleyBp);
    [valley, locsDown] = findpeaks(-peaceValleyBp,'MinPeakDistance',6,'MinPeakHeight', -0.98 * mean(peacebp(:)));
    kbp = zeros(floor(size(locsDown,1) / 2), 1);
    i = 1;
    count = 1;
    while(i < size(locsDown,1))
        % 计算两个波谷之间的平均压
        peacePulse = peaceValleyBp(locsDown(i):locsDown(i + 1));
        peacePulsePeak = max(peacePulse);
        peacePulseMean = mean(peacePulse);
        peacePulseDown = min(peacePulse);
        kbp(count, 1) = (peacePulseMean - peacePulseDown) / (peacePulsePeak - peacePulseDown);
        i = i + 1;
        count = count + 1;
    end
    peaceKbpAvg = mean(kbp)
    % 先从主波峰开始计算
    figure(1)
    hold on;
    plot(peaceTimes, peacebp);
    plot(peaceTimes(locs), pks,"*");
    plot(peaceTimes(locsDown), -valley,"o");
    hold off;
    %1.1 单周期
    peacePtt = zeros(floor(size(locs,1) / 2), 1);
    i = 1;
    count = 1;
    while(i < size(locs,1))
        if(pks(i + 1) < pks(i))
              peacePtt(count, 1) = peaceTimes(locs(i + 1,1)) - peaceTimes(locs(i, 1));
              i = i + 2;
              count = count + 1;
        else
            i = i + 1;
        end
    end
    % 1.1.1 分类
    peacePttHigh = 350;
    peacePttMid = 260;
    peacePttLow = 200;
    peacePttHighCount = 0;
    peacePttHighSum = 0;
    peacePttLowCount = 0;
    peacePttLowSum = 0;
    for i=1:length(peacePtt)
        if peacePtt(i) > peacePttMid && peacePtt(i) < peacePttHigh
            peacePttHighSum = peacePttHighSum + peacePtt(i);
            peacePttHighCount = peacePttHighCount + 1;
        elseif peacePtt(i) > peacePttLow && peacePtt(i) < peacePttMid
            peacePttLowSum = peacePttLowSum + peacePtt(i);
            peacePttLowCount = peacePttLowCount + 1;     
        end 

    end
    peacePttHighAvg = peacePttHighSum / peacePttHighCount;
    peacePttLowAvg = peacePttLowSum / peacePttLowCount;
    %1.2 三周期
    peaceThreeAverage = zeros(floor(size(peacePtt,1) / 3), 1);
    for i=1:size(peaceThreeAverage,1)
        peaceThreeAverage(i, 1) = (peacePtt((i - 1) * 3 + 1) + peacePtt((i - 1) * 3 + 2) + peacePtt((i - 1) * 3 + 3)) / 3;
    end
    %1.3 四周期
    peaceFourAverage = zeros(floor(size(peacePtt,1) / 4), 1);
    for i=1:size(peaceFourAverage,1)
        peaceFourAverage(i, 1) = (peacePtt((i - 1) * 4 + 1) + peacePtt((i - 1) * 4 + 2) + peacePtt((i - 1) * 4 + 3) + peacePtt((i - 1) * 4 + 4)) / 4;
    end
    %1.4 五周期
    peaceFiveAverage = zeros(floor(size(peacePtt,1) / 5), 1);
    for i=1:size(peaceFiveAverage,1)
        peaceFiveAverage(i, 1) = (peacePtt((i - 1) * 5 + 1) + peacePtt((i - 1) * 5 + 2) + peacePtt((i - 1) * 5 + 3)+ peacePtt((i - 1) * 5 + 4) + peacePtt((i - 1) * 5 + 5)) / 5;
    end
    %1.5 六周期
    peaceSixAverage = zeros(floor(size(peacePtt,1) / 6), 1);
    for i=1:size(peaceSixAverage,1)
        peaceSixAverage(i, 1) = (peacePtt((i - 1) * 6 + 1) + peacePtt((i - 1) * 6 + 2) + peacePtt((i - 1) * 6 + 3)+ peacePtt((i - 1) * 6 + 4) + peacePtt((i - 1) * 6 + 5) + peacePtt((i - 1) * 6 + 6)) / 6;
    end
    figure(2)
    plot(peacePtt, 'r.')

    % 2.加压阶段
    inflateStart = 3800;
    inflateStop = 4600;
    inflateTimes = times(inflateStart:inflateStop,1);
    inflateTimes = cell2mat(inflateTimes);
    % 2.1基线去除
    inflatebpBefore = bp(inflateStart:inflateStop,1);
    inflatebpBefore = cell2mat(inflatebpBefore);
    inflatebp = inflatebpBefore;
    fmaxd = 5;
    fs = 1000;
    fmaxn = fmaxd/(fs/2);
    [b,a] = butter(1,fmaxn,'low');
    dd = filtfilt(b,a,inflatebp);
    inflatebp = inflatebp-dd;
    [pksBefore, locsBefore] = findpeaks(inflatebpBefore,'MinPeakDistance',6,'MinPeakHeight',820);
    [pks, locs] = findpeaks(inflatebp,'MinPeakHeight',-19,'MinPeakDistance',6);
    % 谷值计算、KBP计算
    inflateValleyBp = inflatebp(1:200, 1);
    [inflateValley, inflateLocsDown] = findpeaks(-inflateValleyBp,'MinPeakDistance',6,'MinPeakHeight', 66);
    inflatekbp = zeros(floor(size(inflateLocsDown,1) / 2), 1);
    i = 1;
    count = 1;
    while(i < size(inflateLocsDown,1))
        % 计算两个波谷之间的平均压
        inflatePulse = inflateValleyBp(inflateLocsDown(i):inflateLocsDown(i + 1));
        inflatePulsePeak = max(inflatePulse);
        inflatePulseMean = mean(inflatePulse);
        inflatePulseDown = min(inflatePulse);
        inflatekbp(count, 1) = (inflatePulseMean - inflatePulseDown) / (inflatePulsePeak - inflatePulseDown);
        i = i + 1;
        count = count + 1;
    end
    inflateKbpAvg = mean(inflatekbp)
    figure(3);
    hold on;
    plot(inflateTimes, inflatebpBefore, 'LineWidth',2);
    plot(inflateTimes(locsBefore), pksBefore,"*");
    plot(inflateTimes, inflatebp,'LineWidth',2);
    plot(inflateTimes(locs), pks,"*");
    plot(inflateTimes(inflateLocsDown), -inflateValley,"o");
    hold off;
    %2.2 单周期
    inflatePtt = zeros(floor(size(locs,1) / 2), 1);
    i = 1;
    count = 1;
    while(i < size(locs,1))
        if(pks(i + 1) < pks(i))
              inflatePtt(count, 1) = inflateTimes(locs(i + 1,1)) - inflateTimes(locs(i, 1));
              i = i + 2;
              count = count + 1;
        else
            i = i + 1;
        end
    end
    % 2.2.1 分类
    inflatePttHigh = 350;
    inflatePttMid = 260;
    inflatePttLow = 200;
    inflatePttHighCount = 0;
    inflatePttHighSum = 0;
    inflatePttLowCount = 0;
    inflatePttLowSum = 0;
    for i=1:length(inflatePtt)
        if inflatePtt(i) > inflatePttMid && inflatePtt(i) < inflatePttHigh
            inflatePttHighSum   = inflatePttHighSum   + inflatePtt(i);
            inflatePttHighCount = inflatePttHighCount + 1;
        elseif inflatePtt(i) > inflatePttLow && inflatePtt(i) < inflatePttMid
            inflatePttLowSum   = inflatePttLowSum   + inflatePtt(i);
            inflatePttLowCount = inflatePttLowCount + 1;     
        end 
    end
    inflatePttHighAvg = inflatePttHighSum / inflatePttHighCount;
    inflatePttLowAvg  = inflatePttLowSum  / inflatePttLowCount;
    %2.3 三周期
    inflateThreeAverage = zeros(floor(size(inflatePtt,1) / 3), 1);
    for i=1:size(inflateThreeAverage,1)
        inflateThreeAverage(i, 1) = (inflatePtt((i - 1) * 3 + 1) + inflatePtt((i - 1) * 3 + 2) + inflatePtt((i - 1) * 3 + 3)) / 3;
    end
    %2.4 四周期
    inflateFourAverage = zeros(floor(size(inflatePtt,1) / 4), 1);
    for i=1:size(inflateFourAverage,1)
        inflateFourAverage(i, 1) = (inflatePtt((i - 1) * 4 + 1) + inflatePtt((i - 1) * 4 + 2) + inflatePtt((i - 1) * 4 + 3) + inflatePtt((i - 1) * 4 + 4)) / 4;
    end
    %1.4 五周期
    inflateFiveAverage = zeros(floor(size(inflatePtt,1) / 5), 1);
    for i=1:size(inflateFiveAverage,1)
        inflateFiveAverage(i, 1) = (inflatePtt((i - 1) * 5 + 1) + inflatePtt((i - 1) * 5 + 2) + inflatePtt((i - 1) * 5 + 3)+ inflatePtt((i - 1) * 5 + 4) + inflatePtt((i - 1) * 5 + 5)) / 5;
    end
    %2.5 六周期
    inflateSixAverage = zeros(floor(size(inflatePtt,1) / 6), 1);
    for i=1:size(inflateSixAverage,1)
        inflateSixAverage(i, 1) = (inflatePtt((i - 1) * 6 + 1) + inflatePtt((i - 1) * 6 + 2) + inflatePtt((i - 1) * 6 + 3)+ inflatePtt((i - 1) * 6 + 4) + inflatePtt((i - 1) * 6 + 5) + inflatePtt((i - 1) * 6 + 6)) / 6;
    end
    figure(4)
    subplot(2,2,1)
    plot(inflateThreeAverage,'r.')
    subplot(2,2,2)
    plot(inflateFourAverage,'r.')
    subplot(2,2,3)
    plot(inflateFiveAverage,'r.')
    subplot(2,2,4)
    plot(inflateSixAverage,'r.')
    figure(5)
    plot(inflatePtt, 'r.')
end