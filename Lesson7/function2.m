function function2
syms x
warning off
y = input('Enter the function y = ');
set(ezplot(char(y), [-20, 20, -20, 20]), 'Color', 'green', 'LineWidth', 2)
hold on
a = limit(y, x, inf);
b = limit(y, x, -inf);

if (a == b && isreal(a))
    text = ['Graph has horizontal asymptote: y = ' char(a)];
    disp(text)
    disp('Graph has no oblique asymptote')
    ezplot(char(a), [-20, 20, -20, 20])
else
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
b = double(b);
if isinf(b)
    a1 = limit(y/x, x, -inf);
    if isreal(a1)
        b1 = limit(y - a1*x, x, -inf);
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
[~, m] = numden(y);
k = 0;
m = solve(m);  % Find x-values making y undefined
m = double(m);
c = solve(exp(y)); c = double(c);
d = solve(1/log(y)); d = double(d);
e = solve(1/exp(y)); e = double(e);
m = [0; c; e; d; m]; 
m = unique(m);
i = 1;
while i <= length(m)
    if ~isreal(m(i,1))
        m(i,:) = [];
        i = i - 1;
    end
    i = i + 1;
end

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

if k == 0
    disp('Graph has no vertical asymptote')
end

axis([-20 20 -20 20])
hold off
end
