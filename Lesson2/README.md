### 💻 Explanation of each command line:
```matlab
function integral             % Start of function definition
syms x                       % Declare x as a symbolic variable

f = input('Enter function f1(x) = ');     % Get first function f(x) from user input
g = input('Enter function f2(x) = ');     % Get second function g(x)

m = solve(char(f - g), x);                % Find intersection points: f(x) = g(x)
m = double(m);                            % Convert symbolic solutions to numeric (real/complex)

i = 1;
while i <= length(m)                      % Iterate through all solutions
    if imag(m(i)) > 1e-4                  % If the imaginary part is large, discard
        m(i) = [];
        i = i - 1;
    else
        m(i) = m(i) - imag(m(i)) * 1i;    % If imaginary part is tiny (~0), treat as real
    end
    i = i + 1;
end

m = unique(m);                            % Remove duplicate roots if any

if length(m) <= 1
    % If fewer than 2 real intersection points, area can't be computed
    disp('Functions f1 and f2 intersect at less than two points — unable to compute area between them.');
else
    area = 0;
    for i = 1:length(m)-1
        % Compute definite integral between each pair of intersection points
        area = area + abs(int(f - g, x, m(i), m(i+1)));
    end
    area = double(area);                 % Convert symbolic result to numeric
    disp(['The area between the curves is: ' num2str(area)]);
end

% Visualization of both functions on same plot
ezplot(f)
hold on
ezplot(g)
hold off
end
