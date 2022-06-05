clear
clc
%addpath('lab2_4');
s = tf('s');
%% minimum phase
sys = minphase;
G = sys.C/(s*eye(4)-sys.A)*sys.B;
wc = 0.1;
phim = pi/3;
%% 1: controller design
%determine Tij
[~,phi11] = bode(G(1,1),wc);
[~,phi22] = bode(G(2,2),wc);
Ti1 = (1/wc) * tan(phim - pi/2 - (phi11*pi/180));
Ti2 = (1/wc) * tan(phim - pi/2 - (phi22*pi/180));
%determine Ki
L11 = G(1,1) * (1 + (1/(s*Ti1)));
L22 = G(2,2) * (1 + (1/(s*Ti2)));
[k1,~] = bode(L11,wc);
[k2,~] = bode(L22,wc);
K1 = 1/k1;
K2 = 1/k2;
%decentralized controller
f11 = K1*(1 + (1/(s*Ti1)));
f22 = K2*(1 + (1/(s*Ti2)));
f12 = 0;
f21 = 0;
F = [f11 f12; f21 f22];
L = G*F;
%% 2: sensitivity function S and complementary sensitivity function T
% Sensitivity Function
S = minreal(inv(eye(2)+L));
% Complimentary Sensitivity Function 
T = minreal(inv(eye(2)+L) * L);
%% 3: simulink
sim('closedloop');
figure(1)
plot(uout,'LineWidth',2)
hold on
title('Control Outputs u1 and u2')
legend('u1','u2')
grid on
hold off
figure(2)
plot(yout,'LineWidth',2)
hold on
title('Outputs y1 and y2')
legend('y1','y2')
grid on
hold off
%% Bode diagram of loop gain
figure(3)
margin(L(1,1))
hold on
margin(L(2,2))
grid on
% G11 = 0.0348/(s+0.05645);
% K1 = 1/0.6;
% T1 = 5.8;
% F1 = K1*(1+1/s/T1); % controller u1
% G22 = 0.03013/(s+0.05187);
% K2 = 1.9;
% T2 = 6.2;
% F2 = K2*(1+1/s/T2); % controller u2
% %%
% % margin(G11*F1);
% margin(G22*F2); % check specifications
% %% 2
% F = [F1,0; 0,F2]; % decoupled controller
% S = 1/(eye(2)+G*F);
% T = minreal(G*F*S);
% %%
% nms = nonminphase;
% Gnm = nms.C/(s*eye(4)-nms.A)*nms.B;
% %%
% Gnm1 = Gnm(1,2);
% Knm1 = 1/6.8;
% Tnm1 = 3.93;
% Fnm1 = Knm1*(1+1/s/Tnm1);
% Gnm2 = Gnm(2,1);
% Knm2 = 1/6.96;
% Tnm2 = 4.81;
% Fnm2 = Knm2*(1+1/s/Tnm2);
% %%
% margin(Gnm1*Fnm1);
% margin(Gnm2*Fnm2);
% %%
% Fnm = [0,Fnm1; Fnm2,0];
% Snm = inv(eye(2)+Gnm*Fnm);
% Tnm = minreal(Gnm*Fnm/(eye(2)+Gnm*Fnm));