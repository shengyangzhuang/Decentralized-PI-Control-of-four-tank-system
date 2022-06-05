clear
clc
%% minimum phase case
mp = minphase;
s=tf('s');
%caculate G(s)
G = mp.C*(s*eye(4)-mp.A)^(-1)*mp.B;
%investigate each element of the matrix
g11=G(1,1);g12=G(1,2);g21=G(2,1);g22=G(2,2);
%caculate the poles and zeros of the elements
pole(g11);pole(g12);pole(g21);pole(g22);
tzero(g11);tzero(g12);tzero(g21);tzero(g22);
%caculate the poles and zeros of the multivariable system
pole(G);
tzero(G);
%investigate the largest and smallest singular values
figure(1)
sigma(G);
[sv,w] = sigma(G);
grid on
[sv1_max,idx_1] = max(sv(1,:));
[sv2_max,idx_2] = max(sv(2,:));
[sv_max,id] = max([sv1_max, sv2_max]);
if id ==1
    idx = idx_1;
else
    idx = idx_2;
end
w_max = w(idx);
%caculate H-inf norm
hinfnorm(G);
%investigate RGA at f=0
figure(2)
%bode(G);
G0 = freqresp(G,0);
rga0 = G0.*inv(G0)';
step(G)
grid on
%% non-minimum phase case
% nmp = nonminphase;
% s=tf('s');
% %caculate G(s)
% G = nmp.C*(s*eye(4)-nmp.A)^(-1)*nmp.B;
% %investigate each element of the matrix
% g11=G(1,1);g12=G(1,2);g21=G(2,1);g22=G(2,2);
% %caculate the poles and zeros of the elements
% pole(g11);pole(g12);pole(g21);pole(g22);
% tzero(g11);tzero(g12);tzero(g21);tzero(g22);
% %caculate the poles and zeros of the multivariable system
% pole(G);
% tzero(G);
% %investigate the largest and smallest singular values
% figure(1)
% sigma(G);
% [sv,w] = sigma(G);
% grid on
% [sv1_max,idx_1] = max(sv(1,:));
% [sv2_max,idx_2] = max(sv(2,:));
% [sv_max,id] = max([sv1_max, sv2_max]);
% if id ==1
%     idx = idx_1;
% else
%     idx = idx_2;
% end
% w_max = w(idx);
% %caculate H-inf norm
% hinfnorm(G);
% %investigate RGA at f=0
% figure(2)
% %bode(G);
% G0 = freqresp(G,0);
% rga0 = G0.*G0';
% step(G)
% grid on