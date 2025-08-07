function partialFraction
syms x
f = input('Enter the function f = ');
[num, den] = numden(f);                   % Extract numerator and denominator
num = sym2poly(num);
den = sym2poly(den);
[a, b, c] = residue(num, den);            % Perform partial fraction decomposition
[n, ~] = size(a);
k = 1;
i = 1;

while i <= n
   if imag(a(i,1)) ~= 0 || imag(b(i,1)) ~= 0
       g = a(i,1)/(x - b(i,1));
       h = a(i+1,1)/(x - b(i+1,1));
       l = g + h;
       [t(k,1), m(k,1)] = numden(l);      % Separate real and imaginary parts
       a(i,:) = [];
       a(i,:) = [];
       b(i,:) = [];
       b(i,:) = [];
       n = n - 2;
       k = k + 1;
   else
       i = i + 1;
   end
end
if ~isempty(c)
    j = length(c);
    y = 0;
    y = sym(y);
    for i = 1:j
        y = y + c(i)*x^(j - i);
    end
    text = ['Direct polynomial part = ' char(y)];
else
    text = ('Direct polynomial part = 0');
end

[q, ~] = size(a);
if k == 1
    j = 1;
    for i = 1:q
        if i == 1
            j = 1;
        elseif b(i,1) == b(i-1,1)
            j = j + 1;
        else
            j = 1;
        end
        if a(i,1) ~= 0
            text = [text ' + (' char(num2str(a(i,1)) / (x - num2str(b(i,1)))^j) ')'];
        end
    end
end
if k ~= 1
    j = 1;
    for i = 1:q
        if i == 1
            j = 1;
        elseif b(i,1) == b(i-1,1)
            j = j + 1;
        else
            j = 1;
        end
        if a(i,1) ~= 0
            text = [text ' + (' char(num2str(a(i,1)) / (x - num2str(b(i,1)))^j) ')'];
        end
    end
    for i = 1:k - 1
        text = [text ' + (' char(t(i,1)) ')/(' char(m(i,1)) ')'];
    end
end

disp(text)
end
