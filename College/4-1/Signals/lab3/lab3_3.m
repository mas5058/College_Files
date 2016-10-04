clc; close all; clear all;
disp('num = s^3+8s +2')
den=[1 2  16 18 2];
disp('den = s^2+2s+34')
num= [1 2 1];
%den = [1 2 5];
%disp('X = 4 angle 30(entered in exponential form)')
%X=[4*exp(30j*pi/180)];
%disp('s = 30+10j (sigma = 30 and omega = 100)')
%s=30+10j
%disp('plugged s = 10j into the polynomial and multipled by x')
%y = polyval(num)./polyval(den,s)
disp('Y vector for solution y(t) = ymag*cos(10t+yphase)')
%ymag=abs(y);
%yphase=angle(y)*180/pi;
disp('roots for natural response')
r=roots(den)
t = 0:.1:10
k1 = 1.28;
k2=3.6670;
theta=-1.6472;
yn = k1*exp(-7.91*t)+k2*exp(-.0465*t).*cos((1.124*t)+theta)
plot(t, yn);grid on;title('natural response')
hold on;
disp('num =s^2+2s+34')
num = [1 2 34]
yi = impulse(tf(num,den),t);
plot(t,yi,'r');grid on; legend('natural response','impulse response');
title('natural and impulse responses'); xlabel('t');