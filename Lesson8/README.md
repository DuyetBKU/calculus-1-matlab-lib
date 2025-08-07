### 💻 Explanation of each command line:
```matlab
function vertical_asymptote
% Main function to find and plot vertical, horizontal, and slant asymptotes
% for a parametric curve x = f(t), y = g(t)

syms t
% Declare symbolic variable t

X = input('Enter function x = ');
Y = input('Enter function y = ');
% Prompt user to input parametric functions x(t) and y(t)

[~, m1] = numden(X);
% Get the denominator of x(t), stored in m1

if isreal(m1)
    m1 = [];
    % If denominator is real (i.e., no t-dependence), no singularities
else
    m1 = solve(m1);
    % Solve m1 = 0 to find points where x(t) is undefined
end

[~, m2] = numden(Y);
% Get denominator of y(t)

if isreal(m2)
    m2 = [];
else
    m2 = solve(m2);
    % Solve m2 = 0 to find undefined points in y(t)
end

tn = [m1; m2];
% Combine all singularities from both x(t) and y(t)

tn = unique(tn);
% Remove duplicate values

tn = double(tn);
% Convert symbolic results to numeric values

[m, ~] = size(tn);
% Get number of singular points

tcdung = 1; tcngang = 1; tcxien = 1;
% Initialize counters for vertical, horizontal, and slant asymptotes

x = []; y = []; a = []; b = [];
% Initialize arrays to store asymptote data

if ~isempty(tn)
    for i = 1:m
        if abs(imag(tn(i))) < 1e-12
            % Only consider real values of t (imaginary part near 0)

            ghXr = double(limit(X, t, tn(i), 'right'));
            ghYr = double(limit(Y, t, tn(i), 'right'));
            ghXl = double(limit(X, t, tn(i), 'left'));
            ghYl = double(limit(Y, t, tn(i), 'left'));
            % Compute one-sided limits of x(t) and y(t) at singularities

            % Use helper function tc() to detect and record asymptote types
            [x, y, a, b, tcdung, tcngang, tcxien] = tc(ghXr, ghYr, Y, X, x, y, a, b, tcdung, tcngang, tcxien, tn(i), 'right');
            [x, y, a, b, tcdung, tcngang, tcxien] = tc(ghXl, ghYl, Y, X, x, y, a, b, tcdung, tcngang, tcxien, tn(i), 'left');
        end
    end
end

% Check asymptotic behavior as t → ∞ and t → -∞
ghXr = double(limit(X, inf));
ghYr = double(limit(Y, inf));
ghXl = double(limit(X, -inf));
ghYl = double(limit(Y, -inf));

% Detect asymptotes at infinities
[x, y, a, b, tcdung, tcngang, tcxien] = tc(ghXr, ghYr, Y, X, x, y, a, b, tcdung, tcngang, tcxien, inf, '');
[x, y, a, b, tcdung, tcngang, tcxien] = tc(ghXl, ghYl, Y, X, x, y, a, b, tcdung, tcngang, tcxien, -inf, '');

% Plot the parametric curve
fplot(@(t) double(subs(X, t)), @(t) double(subs(Y, t)), [-100, 100], 'LineWidth', 2);
hold on;

% Plot vertical asymptotes
for i = 1:tcdung-1
    xline(x(i), 'r--', 'LineWidth', 1.5);
end

% Plot horizontal asymptotes
for i = 1:tcngang-1
    yline(y(i), 'g--', 'LineWidth', 1.5);
end

% Plot slant asymptotes: y = a*t + b
t_vals = linspace(-100, 100, 1000);
for i = 1:tcxien-1
    plot(t_vals, a(i)*t_vals + b(i), 'b--', 'LineWidth', 1.5);
end

title('Parametric Curve and Its Asymptotes');
xlabel('x(t)');
ylabel('y(t)');
legend('Curve', 'Vertical Asymptote', 'Horizontal Asymptote', 'Slant Asymptote');
grid on;
hold off;
