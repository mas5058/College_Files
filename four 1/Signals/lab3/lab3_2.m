clc; close all; clear all;
disp('num = s^2+2s +1')
num=[1 -2 1];
disp('den = 1')
den= [1 2 16 18 2];
%den = [1 2 5];
disp('X = 4 angle 30(entered in exponential form)')
X=4;
disp('s = 30+10j (sigma = 30 and omega = 100)')
s=-3;
disp('plugged s = 10j into the polynomial and multipled by x')
y = polyval(num,s)./polyval(den,s).*X
disp('Y vector for solution y(t) = ymag*cos(10t+yphase)')
ymag=abs(y)
yphase=angle(y)*180/pi
disp('roots for natural response')
r=roots(den)