clc; close all; clear all;
t = 0:0.1:2*pi
w = 4;
y = (exp(j*(w*t-(pi/6)))-exp(-j*(w*t-(pi/6))))/(2*j);
figure(4);
plot(t,y);
grid;
xlabel('x');
ylabel('y');
