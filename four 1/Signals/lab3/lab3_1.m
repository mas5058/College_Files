clc; close all; clear all;
disp('num = s^2+2x+5')
num=[1 0 1];
disp('den = s^2+2s+5')
den=[1 2 5];
disp('den = s^2+2s+5')
den = [1 2 5];
disp('X = 2 angle 5(entered in exponential form)')
t = 0:.1:10;
X=[2*exp(-3)];
disp('s = 10j (sigma = 0 and omega = 10)')
s=-3;
disp('plugged s = 10j into the polynomial and multipled by x')
y = polyval(num,s)./polyval(den,s).*X
disp('Y vector for solution y(t) = ymag*cos(10t+yphase)')
ymag=abs(y)
yphase=angle(y)*180/pi
disp('roots for natural response')
r=roots(den)