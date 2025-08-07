function integral
syms x
f = input('Enter function f1(x) = ');
g = input('Enter function f2(x) = ');
m = solve(char(f - g), x);
m = double(m);
i = 1;
while i <= length(m)
    if imag(m(i)) > 1e-4
        m(i) = [];
        i = i - 1;
    else
        m(i) = m(i) - imag(m(i)) * 1i; % Remove tiny imaginary part
    end
    i = i + 1;
end
m = unique(m);

if length(m) <= 1
    disp('Functions f1 and f2 intersect at less than two points — unable to compute area between them.');
else
    area = 0;
    for i = 1:length(m)-1
        area = area + abs(int(f - g, x, m(i), m(i+1)));
    end
    area = double(area);
    msg = ['The area between the curves is: ' num2str(area)];
    disp(msg);
end
ezplot(f)
hold on
ezplot(g)
hold off
end
