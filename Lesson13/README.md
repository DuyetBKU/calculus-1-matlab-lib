### 💻 Explanation of each command line:
```matlab
function Integral3                      % Define a MATLAB function named Integral3
syms x                                  % Declare symbolic variable x

f1 = input('Enter function f1(x) = ');  % Prompt user to input the first piece f1(x)
f2 = input('Enter function f2(x) = ');  % Prompt user to input the second piece f2(x)
f3 = input('Enter function f3(x) = ');  % Prompt user to input the third piece f3(x)

x0 = input('Enter x0 = ');              % Read the first boundary x0 of the piecewise function
x1 = input('Enter x1 = ');              % Read the second boundary x1 of the piecewise function

if x0 > x1                              % Check that x0 is less than or equal to x1
    error('Invalid input: x0 must be less than or equal to x1');
end

disp('Enter interval [a, b]')           % Ask user for the integration interval [a, b]
a = input('a = ');                      % Read value a (start of integration)
b = input('b = ');                      % Read value b (end of integration)

% Now calculate the definite integral S of the piecewise function over [a, b]

if x0 < a
    if x1 >= a && x1 <= b
        % Case 1: Only part of f2 and f3 are within [a, b]
        S = int(f2, x, a, x1) + int(f3, x, x1, b);
    elseif x1 >= b
        % Case 2: Entire interval lies in f2
        S = int(f2, x, a, b);
    else
        % Case 3: Entire interval lies in f3
        S = int(f3, x, x1, b);
    end
elseif x0 >= a && x0 <= b
    if x1 >= a && x1 <= b
        % Case 4: All three pieces (f1, f2, f3) fall inside [a, b]
        S = int(f1, x, a, x0) + int(f2, x, x0, x1) + int(f3, x, x1, b);
    else
        % Case 5: f1 and f2 are inside [a, b], f3 is outside
        S = int(f1, x, a, x0) + int(f2, x, x0, b);
    end
else
    % Case 6: Entire interval lies in f1
    S = int(f1, x, a, b);
end

S = double(S);                          % Convert symbolic result S to a numeric value

message = ['The definite integral of the given piecewise function S = ' num2str(S)];
disp(message)                           % Display the result
end                                     % End of the function
