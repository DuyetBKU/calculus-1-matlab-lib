function Localextrema
syms x
f = input('Enter function f(x): ');
disp('Enter interval (a, b)')
a = input('a = ');
b = input('b = ');
while a > b
    disp('Invalid input: a must be less than b');
    a = input('a = ');
    b = input('b = ');
end

ezplot(char(f))
warning('off')

[~, denominator] = numden(diff(f));
critical_points = [solve(diff(f)); solve(denominator)];
critical_points = double(critical_points);
critical_points = unique(critical_points);

i = 1;
while i <= length(critical_points)
    if abs(imag(critical_points(i))) > 1e-8 || critical_points(i) <= a || critical_points(i) >= b
        critical_points(i) = [];
        i = i - 1;
    else
        critical_points(i) = real(critical_points(i)); % remove small imaginary part
    end
    i = i + 1;
end

count = 0;
for i = 1:length(critical_points)
    second_derivative = double(subs(diff(f, 2), x, critical_points(i)));
    value_at_point = double(subs(f, x, critical_points(i)));
    if second_derivative < 0 && ~isinf(second_derivative)
        disp(['Point (' num2str(critical_points(i)) ', ' num2str(value_at_point) ') is a Local Maximum'])
        text(critical_points(i), value_at_point, ...
             ['(' num2str(critical_points(i)) ', ' num2str(value_at_point) ')']) % mark local max
    elseif second_derivative > 0 && ~isinf(second_derivative)
        disp(['Point (' num2str(critical_points(i)) ', ' num2str(value_at_point) ') is a Local Minimum'])
        text(critical_points(i), value_at_point, ...
             ['(' num2str(critical_points(i)) ', ' num2str(value_at_point) ')']) % mark local min
    else
        count = count + 1;
    end
end

if count == length(critical_points)
    disp('The function has no local extrema in the interval (a, b)')
end
end
