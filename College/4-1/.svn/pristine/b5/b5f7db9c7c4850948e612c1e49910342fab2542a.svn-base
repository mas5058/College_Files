clc; close all; clear all;
x = -10:0.1:10; 
%^^ sets arrary of x that 
%increments numbers by .01 from -10 to 10
num = 4*x.^4 +24*x.^3+36*x.^2-400;
den=x.^2-2*x+5;
y = num./den;
%4x^4+24x^3+36x^2-400 //(x^2-2x+5)
figure(1);
plot(x,y);
grid;
xlabel('x');
ylabel('y');
p1 = [4 24 36 0 -400];
p2 = [1 -2 5];
y2 = polyval (p1,x)./ polyval(p2,x);
figure(2);
plot(x,y2);
grid;
xlabel('x');
ylabel('y');
hold on;
r = roots(p1)
plot(r(1),0,'o');
plot(r(4),0,'o');
%factor p1
%Vd (0, 0.8, 0.02)