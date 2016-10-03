clc; close all; clear all;
x = linspace(0,10,1751);
num = x.^2 - 16;
den = x - 4;
y = num./den;
plot(x,y); grid; xlabel('t');ylabel('y')
k = find(isnan(y));
y(k) = 8;