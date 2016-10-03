clc; close all; clear all;

% None of the lines end with semicolons allowing results to display

syms s R1 L1 C1 ZL ZC ZP symTF %defines variables

[R1] = solve(R1==2,R1)

[L1] = solve(L1==5,L1)

[C1] = solve(C1==2,C1)

[ZL] = solve(ZL==s*L1,ZL)

[ZC] = solve(ZC==1/(s*C1),ZC)

[ZP]=solve(ZP==R1*ZL/(R1+ZL),ZP)

[symTF]=solve(symTF==ZP/(ZC+ZP),symTF) %finds Vout/Vin

[symNum,symDen] = numden(symTF) %Get num and den of Symbolic TF
num = sym2poly(symNum)    %Convert Symbolic num to polynomial
den = sym2poly(symDen)    %Convert Symbolic den to polynomial
TF =tf(num,den) %makes a transfer function

[yi,t]=impulse(TF); %creates step response showing damping
figure(1);
plot(t,yi);

roots(den)

