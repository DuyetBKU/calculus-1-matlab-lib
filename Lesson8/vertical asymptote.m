function verticalasymptote
syms t
X = input('Enter function x = ');
Y = input('Enter function y = ');
[~, m1] = numden(X); % m1 is the denominator of X

if isreal(m1) 
    m1 = []; % if denominator is real, then no singularities
else
    m1 = solve(m1); % otherwise, solve for singularities
end

[~, m2] = numden(Y); % m2 is the denominator of Y

if isreal(m2)
    m2 = [];
else
    m2 = solve(m2);
end

tn = [m1; m2];        % tn is the union of singular points
tn = unique(tn);      
tn = double(tn);      

[m, ~] = size(tn);    

tcdung = 1;   % counter for vertical asymptotes         
tcngang = 1;  % counter for horizontal asymptotes     
tcxien = 1;   % counter for slant asymptotes

x = []; y = []; a = []; b = [];

if ~isempty(tn)
    for i = 1:m
        if abs(imag(tn(i))) < 1e-12
            ghXr = double(limit(X, t, tn(i), 'right'));
            ghYr = double(limit(Y, t, tn(i), 'right'));
            ghXl = double(limit(X, t, tn(i), 'left'));
            ghYl = double(limit(Y, t, tn(i), 'left'));

            [x, y, a, b, tcdung, tcngang, tcxien] = tc(ghXr, ghYr, Y, X, x, y, a, b, tcdung, tcngang, tcxien, tn(i), 'right');
            [x, y, a, b, tcdung, tcngang, tcxien] = tc(ghXl, ghYl, Y, X, x, y, a, b, tcdung, tcngang, tcxien, tn(i), 'left');
        end
    end
end

ghXr = double(limit(X, inf));
ghYr = double(limit(Y, inf));
ghXl = double(limit(X, -inf));
ghYl = double(limit(Y, -inf));

[x, y, a, b, tcdung, tcngang, tcxien] = tc(ghXr, ghYr, Y, X, x, y, a, b, tcdung, tcngang, tcxien, inf, '');
[x, y, a, b, tcdung, tcngang, tcxien] = tc(ghXl, ghYl, Y, X, x, y, a, b, tcdung, tcngang, tcxien, -inf, '');

set(ezplot(X, Y, [-20, 20, -20, 20]), 'Color', 'green', 'LineWidth', 2)
hold on

if tcdung == 1
    disp('The function has no vertical asymptotes')
else
    disp('Vertical asymptotes:')
    x = unique(x);
    [k, ~] = size(x);
    for i = 1:k
        disp(['x = ' num2str(x(i))])
        text = ['x - (' num2str(x(i)) ') + 0*y'];
        set(ezplot(text, [-50, 50, -50, 50]), 'Color', 'blue', 'LineWidth', 1)
    end
end

if tcngang == 1
    disp('The function has no horizontal asymptotes')
else
    disp('Horizontal asymptotes:')
    y = unique(y);
    [p, ~] = size(y);
    for i = 1:p
        disp(['y = ' num2str(y(i))])
        set(ezplot(num2str(y(i)), [-50, 50, -50, 50]), 'Color', 'blue', 'LineWidth', 1)
    end
end

syms x y
if tcxien == 1
    disp('The function has no slant asymptotes')
else
    disp('Slant asymptotes:')
    xien = a(1:tcxien-1) * x + b(1:tcxien-1);
    xien = unique(xien);
    [q, ~] = size(xien);
    for i = 1:q
        disp(['y = ' char(xien(i))])
        set(ezplot(char(xien(i)), [-50, 50, -50, 50]), 'Color', 'blue', 'LineWidth', 1)
    end
end

axis([-20 20 -20 20])
box off
grid on

title(['Graph and asymptotes of x = ' char(X) ', y = ' char(Y)])
hold off
end
