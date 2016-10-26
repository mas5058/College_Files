clc; close all; clear all;
num = 16*[1 1/2]
den = [1 1/10]
w = logspace(-1, 1);
bode(num,den,w)