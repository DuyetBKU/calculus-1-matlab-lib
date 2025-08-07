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
```
```matlab
function taylor2
syms x
f = input('input f(x)= ');         % Input: symbolic function f(x)
x0 = input('input x0= ');          % Input: expansion center point x₀

% Check if the function tends to 0 as x → x0
if limit(f, x, x0) == 0
    k = 0;
    n = 1;
    taylor = (subs(diff(f, k), x, x0) * (x - x0)^k) / n;   % Start with 0th-order term

    % If the term is 0, keep increasing order until a non-zero term is found
    if taylor == 0
        k = 1;
        while taylor == 0
            n = n * k;     % Compute factorial k!
            taylor = taylor + (subs(diff(f, k), x, x0) * (x - x0)^k) / n;
            k = k + 1;
        end
    end

    disp('The lowest-order nonzero term in the Taylor expansion is:')
    disp(taylor)                           % Show first non-zero term

    text = ['The order of this term is: ' num2str(k - 1)];
    disp(text)                             % Show its order (degree)

    ezplot(f)                              % Plot original function
else
    disp('f(x) is not infinitesimally small at x0')
end
end
```
