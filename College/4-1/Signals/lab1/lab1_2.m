x = [-15, -14, -11,-5, -2, -1, 0, 1, 3, 4];
%y = x.^3+15*x.^2-9
p = [1 15 0 -9];
y=polyval(p ,x);
figure(3);
plot(x, y);
grid; 
xlabel('x');
ylabel('y');
hold on;
r = roots(p);
%sizeof(r);
plot(r(1), 0, 'o');
plot(r(2), 0, 'o');
plot(r(3), 0, 'o');
% plot(r(4), 0, 'o');
