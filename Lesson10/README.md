### 💻 Explanation of each command line:
```matlab
function Localextrema                     % Define a MATLAB function named Localextrema
syms x                                    % Declare symbolic variable x for symbolic computation

f = input('Enter function f(x): ');       % Prompt the user to input a function f(x)
disp('Enter interval (a, b)')             % Prompt the user to input the interval (a, b)

a = input('a = ');                        % Read the value of a
b = input('b = ');                        % Read the value of b

while a > b                               % Ensure that a is less than b
    disp('Invalid input: a must be less than b');
    a = input('a = ');                    % Re-enter a
    b = input('b = ');                    % Re-enter b
end

ezplot(char(f))                           % Plot the function f(x)

warning('off')                            % Turn off warnings (e.g., division by zero)

[~, denominator] = numden(diff(f));       % Get the denominator of the derivative f'(x)

critical_points = [solve(diff(f)); solve(denominator)]; 
% Solve f'(x) = 0 and points where f'(x) is undefined

critical_points = double(critical_points); % Convert symbolic roots to numeric values
critical_points = unique(critical_points); % Remove duplicate values

i = 1;
while i <= length(critical_points)        % Filter out invalid or complex points
    if abs(imag(critical_points(i))) > 1e-8 || ...
       critical_points(i) <= a || critical_points(i) >= b
        critical_points(i) = [];          % Remove complex or out-of-range values
        i = i - 1;
    else
        critical_points(i) = real(critical_points(i)); % Keep only the real part
    end
    i = i + 1;
end

count = 0;                                % Initialize count for non-extrema points

for i = 1:length(critical_points)         % Loop over each critical point
    second_derivative = double(subs(diff(f, 2), x, critical_points(i))); 
    % Evaluate the second derivative at the critical point

    value_at_point = double(subs(f, x, critical_points(i))); 
    % Evaluate the function at the critical point

    if second_derivative < 0 && ~isinf(second_derivative)
        % If the second derivative is negative → local maximum
        disp(['Point (' num2str(critical_points(i)) ', ' num2str(value_at_point) ') is a Local Maximum'])
        text(critical_points(i), value_at_point, ...
             ['(' num2str(critical_points(i)) ', ' num2str(value_at_point) ')']) 
        % Label the point on the graph
    elseif second_derivative > 0 && ~isinf(second_derivative)
        % If the second derivative is positive → local minimum
        disp(['Point (' num2str(critical_points(i)) ', ' num2str(value_at_point) ') is a Local Minimum'])
        text(critical_points(i), value_at_point, ...
             ['(' num2str(critical_points(i)) ', ' num2str(value_at_point) ')']) 
        % Label the point on the graph
    else
        count = count + 1;                % The second derivative test is inconclusive
    end
end

if count == length(critical_points)       % If no extrema were found
    disp('The function has no local extrema in the interval (a, b)')
end
end                                       % End of the function
