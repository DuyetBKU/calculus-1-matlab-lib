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
```matlab
function taylor3
% Estimates the limit of a function f(x) as x → x0 using Taylor series expansion
% when the limit is in the indeterminate form 0/0

syms x
f = input('Enter f(x) = ');                % User inputs the symbolic function f(x)
x0 = input('Compute limit as x → x0: ');   % User inputs the point x0 to evaluate the limit

[num, den] = numden(f);                    % Decompose f into numerator and denominator

% Check if f(x) has indeterminate form 0/0 at x0
if subs(num, x, x0) == 0 && subs(den, x, x0) == 0

    % ---- Find the first non-zero term in the Taylor series of the numerator ----
    k = 0;
    n = 1;
    num_equiv = (subs(diff(num, k), x, x0) * (x - x0)^k) / n;  % Initial term of numerator
    if num_equiv == 0
        k = 1;
        while num_equiv == 0
            n = n * k;  % k!
            num_equiv = num_equiv + (subs(diff(num, k), x, x0) * (x - x0)^k) / n;
            k = k + 1;
        end
    end

    % ---- Find the first non-zero term in the Taylor series of the denominator ----
    k = 0;
    n = 1;
    den_equiv = (subs(diff(den, k), x, x0) * (x - x0)^k) / n;  % Initial term of denominator
    if den_equiv == 0
        k = 1;
        while den_equiv == 0
            n = n * k;  % k!
            den_equiv = den_equiv + (subs(diff(den, k), x, x0) * (x - x0)^k) / n;
            k = k + 1;
        end
    end

    % ---- Approximate the limit using the lowest non-zero terms of numerator and denominator ----
    lim = num_equiv / den_equiv;       % Ratio of lowest-order terms
    lim = subs(lim, x, x0);            % Evaluate at x = x0
    lim = double(lim);                 % Convert symbolic result to numeric

    text = ['The value of the limit is: ' num2str(lim)];
    disp(text)                         % Display the result

else
    disp('The limit is not in 0/0 indeterminate form')  % No Taylor expansion needed
end
end

```
