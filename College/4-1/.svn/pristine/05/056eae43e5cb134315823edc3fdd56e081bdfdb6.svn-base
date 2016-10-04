clc; close all; clear all;
t = linspace(0,4*pi,201);
%creates a vector using linespace(201 points)
w = 0.5;
phase = -pi./3;
theta = w*t + phase;
y = (exp(1j*theta)+exp(-1j*theta))./2; 
plot(t,y); grid; xlabel('t');ylabel('y')