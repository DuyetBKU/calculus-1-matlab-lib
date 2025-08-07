### 💻 Explanation of each command line:
```matlab
function integral6
syms x
f = input('Enter function f(x) = ');          % Input symbolic function f(x)
disp('Enter the interval [a, b]')
a = input('a = ');                            % Lower bound of the interval
b = input('b = ');                            % Upper bound of the interval

[~, denom] = numden(f);                       % Extract denominator of f(x)
singularities = [];

% Identify potential singularities (where denominator is zero)
if ~isreal(denom)
   singularities = solve(denom);              % Solve denominator = 0
   singularities = double(singularities);     % Convert to numeric

   % Filter out complex and out-of-interval singularities
   i = 1;
   while i <= length(singularities)
     if abs(imag(singularities(i))) > 1e-5 || singularities(i) < a || singularities(i) > b
         singularities(i,:) = [];             % Remove invalid singularities
         i = i - 1;
     else
         singularities(i) = singularities(i) - imag(singularities(i)) * 1i;  % Keep real part
     end
     i = i + 1;
   end
   singularities = union(singularities, singularities);  % Remove duplicates
end

% Classify the type of integral
if isempty(singularities) && ~isinf(a) && ~isinf(b)
    disp('The integral of f is a regular (proper) integral')
elseif ~isempty(singularities) && ~isinf(a) && ~isinf(b)
    disp('The integral of f is an improper integral of the second kind')  % due to discontinuities
elseif isempty(singularities) && (isinf(a) || isinf(b))
    disp('The integral of f is an improper integral of the first kind')   % due to infinite limits
else
    disp('The integral of f is an improper integral of both first and second kinds')
end

% Calculate the integral over subintervals separated by singularities
singularities = [a; singularities; b];        % Include endpoints
singularities = union(singularities, singularities);
S = 0;
for i = 1:length(singularities)-1
    S = S + abs(int(f, x, singularities(i), singularities(i+1)));
end

% Display result based on whether it's real/convergent
if isreal(S)
    S = double(S);
    text = ['The integral of f is convergent and equals: ' num2str(S)];
    disp(text)
else
    text = 'The integral of f is divergent (improper integral)';
    disp(text)
end

ezplot(f)   % Plot the function
end
