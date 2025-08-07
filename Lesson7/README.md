### 💻 Explanation of each command line:
```matlab
function function2
% Define a symbolic variable x
syms x
warning off  % Disable warnings for cleaner output

% Prompt user to input a function y in terms of x
y = input('Enter the function y = ');

% Plot the function y over a fixed range with green color and thick line
set(ezplot(char(y), [-20, 20, -20, 20]), 'Color', 'green', 'LineWidth', 2)
hold on  % Keep the current plot so we can draw asymptotes on top of it

% Compute the horizontal limits as x approaches ∞ and -∞
a = limit(y, x, inf);
b = limit(y, x, -inf);

% Check for horizontal asymptotes
if (a == b && isreal(a))
    % If both limits exist, are equal, and real ⇒ 1 horizontal asymptote
    text = ['Graph has horizontal asymptote: y = ' char(a)];
    disp(text)
    disp('Graph has no oblique asymptote')
    ezplot(char(a), [-20, 20, -20, 20])  % Draw horizontal asymptote
else
    % Check each direction separately
    if isreal(a)
        text = ['Graph has horizontal asymptote: y = ' char(a) ' as x → ∞'];
        disp(text)
        disp('Graph has no oblique asymptote as x → ∞')
        ezplot(char(a), [-20, 20, -20, 20])
    else
        disp('Graph has no horizontal asymptote as x → ∞');
    end

    if isreal(b)
        text = ['Graph has horizontal asymptote: y = ' char(b) ' as x → -∞'];
        disp(text)
        disp('Graph has no oblique asymptote as x → -∞')
        ezplot(char(b), [-20, 20, -20, 20])
    else
        disp('Graph has no horizontal asymptote as x → -∞');
    end
end

% Check for oblique asymptote as x → -∞
b = double(b);  % Convert to numeric to check for ±∞
if isinf(b)
    a1 = limit(y/x, x, -inf);  % Compute slope of asymptote
    if isreal(a1)
        b1 = limit(y - a1*x, x, -inf);  % Compute y-intercept
        if isreal(b1)
            text = ['Graph has oblique asymptote: y = ' char(a1*x + b1) ' as x → -∞'];
            disp(text)
            ezplot(char(a1*x + b1), [-20, 20, -20, 20])
        else
            disp('Graph has no oblique asymptote as x → -∞');
        end
    else
        disp('Graph has no oblique asymptote as x → -∞');
    end
end

% Check for oblique asymptote as x → ∞
a = double(a);
if isinf(a)
    a1 = limit(y/x, x, inf);
    if isreal(a1)
        b1 = limit(y - a1*x, x, inf);
        if isreal(b1)
            text = ['Graph has oblique asymptote: y = ' char(a1*x + b1) ' as x → ∞'];
            disp(text)
            ezplot(char(a1*x + b1), [-20, 20, -20, 20])
        else
            disp('Graph has no oblique asymptote as x → ∞');
        end
    else
        disp('Graph has no oblique asymptote as x → ∞');
    end
end

% Now check for vertical asymptotes
[~, m] = numden(y);  % Extract denominator of y
k = 0;               % Counter for number of vertical asymptotes
m = solve(m);        % Solve for x where denominator = 0 (undefined points)
m = double(m);       % Convert to numeric

% Add extra possible singularities based on exponential/log forms
c = solve(exp(y));     c = double(c);
d = solve(1/log(y));   d = double(d);
e = solve(1/exp(y));   e = double(e);
m = [0; c; e; d; m];    % Combine all potential singular points
m = unique(m);          % Remove duplicates

% Remove complex values (we only want real x for asymptotes)
i = 1;
while i <= length(m)
    if ~isreal(m(i,1))
        m(i,:) = [];
        i = i - 1;
    end
    i = i + 1;
end

% Loop through each possible vertical asymptote
for i = 1:length(m)
    a = double(limit(y, x, m(i,1), 'right'));
    b = double(limit(y, x, m(i,1), 'left'));

    if isinf(a) && isinf(b)
        text = ['Graph has vertical asymptote: x = ' num2str(m(i,1))];
        disp(text);
        eq = [char(x - num2str(m(i,1))) '+0*y'];
        set(ezplot(eq, [-20, 20, -20, 20]), 'Color', 'blue', 'LineWidth', 1);
        k = k + 1;
    else
        if isinf(a)
            text = ['Graph has vertical asymptote: x = ' num2str(m(i,1)) ' as x → ' num2str(m(i,1)) '+'];
            disp(text);
            eq = [char(x - num2str(m(i,1))) '+0*y'];
            set(ezplot(eq, [-20, 20, -20, 20]), 'Color', 'blue', 'LineWidth', 1);
            k = k + 1;
        end
        if isinf(b)
            text = ['Graph has vertical asymptote: x = ' num2str(m(i,1)) ' as x → ' num2str(m(i,1)) '-'];
            disp(text);
            eq = [char(x - num2str(m(i,1))) '+0*y'];
            set(ezplot(eq, [-20, 20, -20, 20]), 'Color', 'blue', 'LineWidth', 1);
            k = k + 1;
        end
    end
end

% If no vertical asymptote found
if k == 0
    disp('Graph has no vertical asymptote')
end

% Fix axis range and finish plot
axis([-20 20 -20 20])
hold off
end
