x = linspace(-10,10, 201);
num = sqrt(4+x.^4+24*x.^3+36*x.^2+400);
den = x.^2-2*x+5;
magy = num./den;
plot(x,magy); grid; xlabel('x');ylabel('mag y')