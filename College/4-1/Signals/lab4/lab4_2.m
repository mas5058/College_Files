clc; close all; clear all;

% None of the lines end with semicolons allowing results to display

syms s R2 L2 C2 ZL ZC ZP ZT symTF %defines variables

% [R2] = solve(R1==2,R1)

[L2] = solve(L2==1,L2)

% [C2] = solve(C1==2,C1)

[ZL] = solve(ZL==s*L2,ZL)

[ZC] = solve(ZC==1/(s*C2),ZC)

%[ZP]=solve(ZP==R2*ZL/(R2+ZL),ZP)

ZT = solve(ZT==ZL+ZC+R2, ZT)

[symTF]=solve((symTF==ZC/ZT),symTF) %finds Vout/Vin

[symNum,symDen] = numden(symTF) %Get num and den of Symbolic TF
num = sym2poly(symNum)    %Convert Symbolic num to polynomial
den = sym2poly(symDen)    %Convert Symbolic den to polynomial
TF =tf(num,den) %makes a transfer function

[yi,t]=impulse(TF); %creates step response showing damping
figure(1);
plot(t,yi);

roots(den)

