### 💻 Explanation of each command line:
```matlab
function taylor
syms x                              % Declare symbolic variable x
f = input('Enter function f(x) = ');               % Input: symbolic function f(x)
x0 = input('Enter the expansion point x0 = ');     % Input: center point x0
a = input('Enter the degree of the Taylor expansion: ');   % Input: expansion degree

% Initialize values
k = 0;
n = 1;
taylor = (subs(diff(f, k), x, x0) * (x - x0)^k) / n;    % First term of the series (k = 0)
taylor = double(taylor);                               % Convert symbolic to numeric

% Clean small numerical noise
if abs(taylor) < 1e-6
    taylor = 0;
end

% Compute the Taylor series from k = 1 to a
k = 1;
while k <= a
    n = n * k;                              % Compute factorial (k!)
    term = subs(diff(f, k), x, x0);         % Derivative of f(x) evaluated at x0
    if abs(term) > 1e-7                     % Ignore near-zero terms
        taylor = taylor + (term * (x - x0)^k) / n;   % Add k-th term to series
    end
    k = k + 1;
end

disp('The Taylor expansion of f is:')
disp(taylor)                               % Output the full Taylor polynomial
end
