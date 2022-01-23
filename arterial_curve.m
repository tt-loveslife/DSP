% range of transmural pressure
transmural_pressure = -80:0.001:80;
% range of transmural pressure center
center = -55:0.05:55;
left30 = center - 15;
right30 = center + 15;
left40 = center - 20;
right40 = center + 20;
left50 = center - 25;
right50 = center + 25;

%     subject01 older than b2 subject02 years old 
%     subject02 and subject03 has different gender
% const b1 varies from people to people
b1 = [0.96;1.36;1.63];
% const b2 varies from people to people
b2 = [0.022;0.045;0.047];
% vascular compliance curve
figure(1)
hold on
y1 = b1(1) ./ (1 + exp(-b2(1) * transmural_pressure));
plot(transmural_pressure, y1,"-")
y1 = b1(2) ./ (1 + exp(-b2(2) * transmural_pressure));
plot(transmural_pressure, y1,"--")
y1 = b1(3) ./ (1 + exp(-b2(3) * transmural_pressure));
plot(transmural_pressure, y1,"-.")
legend('subject01','subject02','subject03')
xlabel('transmural pressure(mmHg)')
ylabel('PPG Output(V)')
title("原始数据拟合")
hold off

% plot separately
figure(2)
hold on
% standard curve
c1 = b1(1) * b2(1) * exp(-b2(1) * transmural_pressure) ./ (1 + exp(-b2(1) * transmural_pressure)).^ 2;
plot(transmural_pressure, c1,"-")
% the slop when p amp is 30Mpa
c1slop30 = (b1(1) ./ (1 + exp(-b2(1) * right30)) - b1(1) ./ (1 + exp(-b2(1) * left30))) / 30;
plot(center, c1slop30)
% the slop when p amp is 40Mpa
c1slop40 = (b1(1) ./ (1 + exp(-b2(1) * right40)) - b1(1) ./ (1 + exp(-b2(1) * left40))) / 40;
plot(center, c1slop40)
% the slop when p amp is 50Mpa
c1slop50 = (b1(1) ./ (1 + exp(-b2(1) * right50)) - b1(1) ./ (1 + exp(-b2(1) * left50))) / 50;
plot(center, c1slop50,'k')
title("Subject01---搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

figure(3)
hold on
% standard curve
c2 = b1(2) * b2(2) * exp(-b2(2) * transmural_pressure) ./ (1 + exp(-b2(2) * transmural_pressure)).^ 2;
plot(transmural_pressure, c2,"-")
% the slop when p amp is 30Mpa
c2slop30 = (b1(2) ./ (1 + exp(-b2(2) * right30)) - b1(2) ./ (1 + exp(-b2(2) * left30))) / 30;
plot(center, c2slop30)
% the slop when p amp is 40Mpa
c2slop40 = (b1(2) ./ (1 + exp(-b2(2) * right40)) - b1(2) ./ (1 + exp(-b2(2) * left40))) / 40;
plot(center, c2slop40)
% the slop when p amp is 50Mpa
c2slop50 = (b1(2) ./ (1 + exp(-b2(2) * right50)) - b1(2) ./ (1 + exp(-b2(2) * left50))) / 50;
plot(center, c2slop50,'k')
title("Subject02---搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

figure(4)
hold on
% standard curve
c3 = b1(3) * b2(3) * exp(-b2(3) * transmural_pressure) ./ (1 + exp(-b2(3) * transmural_pressure)).^ 2;
plot(transmural_pressure, c3,"-")
% the slop when p amp is 30Mpa
c3slop30 = (b1(3) ./ (1 + exp(-b2(3) * right30)) - b1(3) ./ (1 + exp(-b2(3) * left30))) / 30;
plot(center, c3slop30)
% the slop when p amp is 40Mpa
c3slop40 = (b1(3) ./ (1 + exp(-b2(3) * right40)) - b1(3) ./ (1 + exp(-b2(3) * left40))) / 40;
plot(center, c3slop40)
% the slop when p amp is 50Mpa
c3slop50 = (b1(3) ./ (1 + exp(-b2(3) * right50)) - b1(3) ./ (1 + exp(-b2(3) * left50))) / 50;
plot(center, c3slop50,'k')
title("Subject03---搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

% difference between three standard curves
figure(5)
hold on
plot(transmural_pressure, c1,"-")
plot(transmural_pressure, c2,"--")
plot(transmural_pressure, c3,"-.")
title("原始数据拟合")
legend('subject#01', "subject#02","subject#03")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')

% 血压波动状况下的幅值归一化曲线
c1AmpStd = c1 / max(c1);
c2AmpStd = c2 / max(c2);
c3AmpStd = c3 / max(c3);
c1Slop30AmpStd = (c1slop30) / (max(c1slop30));
c2Slop30AmpStd = (c2slop30) / (max(c2slop30));
c3Slop30AmpStd = (c3slop30) / (max(c3slop30));
c1Slop40AmpStd = (c1slop40) / (max(c1slop40));
c2Slop40AmpStd = (c2slop40) / (max(c2slop40));
c3Slop40AmpStd = (c3slop40) / (max(c3slop40));
c1Slop50AmpStd = (c1slop50) / (max(c1slop50));
c2Slop50AmpStd = (c2slop50) / (max(c2slop50));
c3Slop50AmpStd = (c3slop50) / (max(c3slop50));
figure(6)
hold on
% standard curve
plot(transmural_pressure, c1AmpStd,"-")
% the slop when p amp is 30Mpa
plot(center, c1Slop30AmpStd)
% the slop when p amp is 40Mpa
plot(center, c1Slop40AmpStd)
% the slop when p amp is 50Mpa
plot(center, c1Slop50AmpStd)
title("Pulse顺应性")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

figure(7)
hold on
% standard curve
plot(transmural_pressure, c2AmpStd,"-")
% the slop when p amp is 30Mpa
plot(center, c2Slop30AmpStd)
% the slop when p amp is 40Mpa
plot(center, c2Slop40AmpStd)
% the slop when p amp is 50Mpa
plot(center, c2Slop50AmpStd)
title("Pulse顺应性")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

figure(8)
hold on
% standard curve
plot(transmural_pressure, (c3) / (max(c3)),"-")
% the slop when p amp is 30Mpa
plot(center, c3Slop30AmpStd)
% the slop when p amp is 40Mpa
plot(center, c3Slop40AmpStd)
% the slop when p amp is 50Mpa
plot(center, c3Slop50AmpStd)
title("Pulse顺应性")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

% 3 幅值归一化分析
transmural_pressure_loc = find(transmural_pressure == 40);
center_loc = find(center == 40);

% 3.1.1 透壁压 = 40mmHg时，对象1各个压力波动下顺应性大小
c1_complaince = c1AmpStd(transmural_pressure_loc);
c130_complaince = c1Slop30AmpStd(center_loc);
c140_complaince = c1Slop40AmpStd(center_loc);
c150_complaince = c1Slop50AmpStd(center_loc);

% 3.1.2 顺应性大小为0.8时，，对象1各个压力波动下的透壁压
c1_transmural = transmural_pressure(123753);
c130_transmural = center(215);
c140_transmural = center(206);
c150_transmural = center(195);

% 3.2.1 透壁压 = 40mmHg时，对象2各个压力波动下顺应性大小
c2_complaince = c2AmpStd(transmural_pressure_loc);
c230_complaince = c2Slop30AmpStd(center_loc);
c240_complaince = c2Slop40AmpStd(center_loc);
c250_complaince = c2Slop50AmpStd(center_loc);

% 3.2.2 顺应性大小为0.8时，，对象2各个压力波动下的透壁压
c2_transmural = transmural_pressure(58611);
c230_transmural = center(650);
c240_transmural = center(633);
c250_transmural = center(610);

% 3.2.3 顺应性大小为0.4时，，对象2各个压力波动下的透壁压
c2_transmural_4 = transmural_pressure(34144);
c230_transmural_4_ = center(145);
c240_transmural_4 = center(115);
c250_transmural_4 = center(77);

% 3.3.1 透壁压 = 40mmHg时，对象3各个压力波动下顺应性大小
c3_complaince = c3AmpStd(transmural_pressure_loc)
c330_complaince = c3Slop30AmpStd(center_loc)
c340_complaince = c3Slop40AmpStd(center_loc)
c350_complaince = c3Slop50AmpStd(center_loc)

% 3.3.2 顺应性大小为0.8时，，对象3各个压力波动下的透壁压
c3_transmural = transmural_pressure(59521);
c330_transmural = center(668);
c340_transmural = center(649);
c350_transmural = center(625);

% 3.3.3 顺应性大小为0.4时，，对象3各个压力波动下的透壁压
c3_transmural_4 = transmural_pressure(36095);
c330_transmural_4_ = center(182);
c340_transmural_4 = center(151);
c350_transmural_4 = center(112);
