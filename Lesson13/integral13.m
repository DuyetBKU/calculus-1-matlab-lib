function Integral3
syms x
f1 = input('Enter function f1(x) = ');
f2 = input('Enter function f2(x) = ');
f3 = input('Enter function f3(x) = ');
x0 = input('Enter x0 = ');
x1 = input('Enter x1 = ');

if x0 > x1
    error('Invalid input: x0 must be less than or equal to x1');
end

disp('Enter interval [a, b]')
a = input('a = ');
b = input('b = ');

if x0 < a
    if x1 >= a && x1 <= b
        S = int(f2, x, a, x1) + int(f3, x, x1, b);
    elseif x1 >= b
        S = int(f2, x, a, b);
    else
        S = int(f3, x, x1, b);
    end
elseif x0 >= a && x0 <= b
    if x1 >= a && x1 <= b
        S = int(f1, x, a, x0) + int(f2, x, x0, x1) + int(f3, x, x1, b);
    else
        S = int(f1, x, a, x0) + int(f2, x, x0, b);
    end
else
    S = int(f1, x, a, b);
end

S = double(S);
message = ['The definite integral of the given piecewise function S = ' num2str(S)];
disp(message)
end
