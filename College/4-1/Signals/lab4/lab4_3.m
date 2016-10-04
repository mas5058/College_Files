clc; close all; clear all;

% None of the lines end with semicolons allowing results to display

syms s R2 L2 c1 gs wn z symTF %defines variables

[c1] = solve(c1 == 1, c1)

[z] = solve(z == .5, z)

[R2] = solve(R2==1,R2)

[wn] = solve(wn==(1/c1),wn)

[L2] = solve(L2==1,L2)

[gs]=solve(gs==((wn.^2)/(s.^2+R2.*wn.*s+wn.^2)))

% [symNum,symDen] = numden(symTF) %Get num and den of Symbolic TF
% num = sym2poly(symNum)    %Convert Symbolic num to polynomial
% den = sym2poly(symDen)    %Convert Symbolic den to polynomial
% TF =tf(num,den) %makes a transfer function

[yi]=impulse(gs); %creates step response showing damping
figure(1);
plot(t,yi);

roots(den)

