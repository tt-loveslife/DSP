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
% const b2 varies from people to people
b2 = [0.022;0.045;0.047];
% vascular compliance curve
figure(1)
hold on
y1 = 1 ./ (1 + exp(-b2(1) * transmural_pressure));
plot(transmural_pressure, y1,"-")
y1 = 1 ./ (1 + exp(-b2(2) * transmural_pressure));
plot(transmural_pressure, y1,"--")
y1 = 1 ./ (1 + exp(-b2(3) * transmural_pressure));
plot(transmural_pressure, y1,"-.")
legend('subject01','subject02','subject03')
xlabel('transmural pressure(mmHg)')
title("DC顺应性")
hold off

% compliance means diff
figure(2)
% first situation
subplot(3,1,1)
hold on
% standard curve
c1 = b2(1) * exp(-b2(1) * transmural_pressure) ./ (1 + exp(-b2(1) * transmural_pressure)).^ 2;
plot(transmural_pressure, c1,"-")
% the slop when p amp is 30Mpa
c1slop30 = (1 ./ (1 + exp(-b2(1) * right30)) - 1 ./ (1 + exp(-b2(1) * left30))) / 30;
plot(center, c1slop30)
% the slop when p amp is 40Mpa
c1slop40 = (1 ./ (1 + exp(-b2(1) * right40)) - 1 ./ (1 + exp(-b2(1) * left40))) / 40;
plot(center, c1slop40)
% the slop when p amp is 50Mpa
c1slop50 = (1 ./ (1 + exp(-b2(1) * right50)) - 1 ./ (1 + exp(-b2(1) * left50))) / 50;
plot(center, c1slop50,'k')
title("Subject01---归一化搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
hold off

% second situation
subplot(3,1,2)
hold on
% standard curve
c2 = b2(2) * exp(-b2(2) * transmural_pressure) ./ (1 + exp(-b2(2) * transmural_pressure)).^ 2;
plot(transmural_pressure, c2,"-")
% the slop when p amp is 30Mpa
c2slop30 = (1 ./ (1 + exp(-b2(2) * right30)) - 1 ./ (1 + exp(-b2(2) * left30))) / 30;
plot(center, c2slop30)
% the slop when p amp is 40Mpa
c2slop40 = (1 ./ (1 + exp(-b2(2) * right40)) - 1 ./ (1 + exp(-b2(2) * left40))) / 40;
plot(center, c2slop40)
% the slop when p amp is 50Mpa
c2slop50 = (1 ./ (1 + exp(-b2(2) * right50)) - 1 ./ (1 + exp(-b2(2) * left50))) / 50;
plot(center, c2slop50,'k')
title("Subject02---归一化搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
hold off

% third situation
subplot(3,1,3)
hold on
% standard curve
c3 = b2(3) * exp(-b2(3) * transmural_pressure) ./ (1 + exp(-b2(3) * transmural_pressure)).^ 2;
plot(transmural_pressure, c3,"-")
% the slop when p amp is 30Mpa
c3slop30 = (1 ./ (1 + exp(-b2(3) * right30)) - 1 ./ (1 + exp(-b2(3) * left30))) / 30;
plot(center, c3slop30)
% the slop when p amp is 40Mpa
c3slop40 = (1 ./ (1 + exp(-b2(3) * right40)) - 1 ./ (1 + exp(-b2(3) * left40))) / 40;
plot(center, c3slop40)
% the slop when p amp is 50Mpa
c3slop50 = (1 ./ (1 + exp(-b2(3) * right50)) - 1 ./ (1 + exp(-b2(3) * left50))) / 50;
plot(center, c3slop50,'k')
title("Subject03---归一化搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
hold off

% plot separately
figure(3)
hold on
% standard curve
c1 = b2(1) * exp(-b2(1) * transmural_pressure) ./ (1 + exp(-b2(1) * transmural_pressure)).^ 2;
plot(transmural_pressure, c1,"-")
% the slop when p amp is 30Mpa
c1slop30 = (1 ./ (1 + exp(-b2(1) * right30)) - 1 ./ (1 + exp(-b2(1) * left30))) / 30;
plot(center, c1slop30)
% the slop when p amp is 40Mpa
c1slop40 = (1 ./ (1 + exp(-b2(1) * right40)) - 1 ./ (1 + exp(-b2(1) * left40))) / 40;
plot(center, c1slop40)
% the slop when p amp is 50Mpa
c1slop50 = (1 ./ (1 + exp(-b2(1) * right50)) - 1 ./ (1 + exp(-b2(1) * left50))) / 50;
plot(center, c1slop50,'k')
title("Subject01---归一化搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

figure(4)
hold on
% standard curve
c2 = b2(2) * exp(-b2(2) * transmural_pressure) ./ (1 + exp(-b2(2) * transmural_pressure)).^ 2;
plot(transmural_pressure, c2,"-")
% the slop when p amp is 30Mpa
c2slop30 = (1 ./ (1 + exp(-b2(2) * right30)) - 1 ./ (1 + exp(-b2(2) * left30))) / 30;
plot(center, c2slop30)
% the slop when p amp is 40Mpa
c2slop40 = (1 ./ (1 + exp(-b2(2) * right40)) - 1 ./ (1 + exp(-b2(2) * left40))) / 40;
plot(center, c2slop40)
% the slop when p amp is 50Mpa
c2slop50 = (1 ./ (1 + exp(-b2(2) * right50)) - 1 ./ (1 + exp(-b2(2) * left50))) / 50;
plot(center, c2slop50,'k')
title("Subject02---归一化搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

figure(5)
hold on
% standard curve
c3 = b2(3) * exp(-b2(3) * transmural_pressure) ./ (1 + exp(-b2(3) * transmural_pressure)).^ 2;
plot(transmural_pressure, c3,"-")
% the slop when p amp is 30Mpa
c3slop30 = (1 ./ (1 + exp(-b2(3) * right30)) - 1 ./ (1 + exp(-b2(3) * left30))) / 30;
plot(center, c3slop30)
% the slop when p amp is 40Mpa
c3slop40 = (1 ./ (1 + exp(-b2(3) * right40)) - 1 ./ (1 + exp(-b2(3) * left40))) / 40;
plot(center, c3slop40)
% the slop when p amp is 50Mpa
c3slop50 = (1 ./ (1 + exp(-b2(3) * right50)) - 1 ./ (1 + exp(-b2(3) * left50))) / 50;
plot(center, c3slop50,'k')
title("Subject03---归一化搏动顺应性曲线")
legend('standard', "30mmHg","40mmHg", "50mmHg")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
hold off

% difference between three standard curves
figure(6)
hold on
plot(transmural_pressure, c1,"-")
plot(transmural_pressure, c2,"--")
plot(transmural_pressure, c3,"-.")
title("数据归一化")
legend('subject#01', "subject#02","subject#03")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')

% 幅值归一化曲线
figure(7)
hold on
plot(transmural_pressure, (c1 - min(c1)) / (max(c1) - min(c1)),"-")
plot(transmural_pressure, (c2 - min(c2)) / (max(c2) - min(c2)),"--")
plot(transmural_pressure, (c3 - min(c3)) / (max(c3) - min(c3)),"-.")
title("AC动脉顺应性曲线")
legend('subject#01', "subject#02","subject#03")
xlabel('transmural pressure(mmHg)')
ylabel('compliance(V/mmHg)')
