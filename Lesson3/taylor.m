function taylor
syms x
f = input('Enter function f(x) = ');
x0 = input('Enter the expansion point x0 = ');
a = input('Enter the degree of the Taylor expansion: ');

% Initialize variables
k = 0;
n = 1;
taylor = (subs(diff(f, k), x, x0) * (x - x0)^k) / n;
taylor = double(taylor);

% Remove very small values (floating point tolerance)
if abs(taylor) < 1e-6
    taylor = 0;
end

% Compute the Taylor expansion up to degree a
k = 1;
while k <= a
    n = n * k;  % Compute factorial k!
    term = subs(diff(f, k), x, x0);
    if abs(term) > 1e-7
        taylor = taylor + (term * (x - x0)^k) / n;
    end
    k = k + 1;
end

disp('The Taylor expansion of f is:')
disp(taylor)
end
