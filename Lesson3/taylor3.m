function taylor3
syms x
f = input('Enter f(x) = ');
x0 = input('Compute limit as x → x0: ');

[num, den] = numden(f);  % Separate numerator and denominator, example 1/2...

if subs(num, x, x0) == 0 && subs(den, x, x0) == 0
    % Handle numerator
    k = 0;
    n = 1;
    num_equiv = (subs(diff(num, k), x, x0) * (x - x0)^k) / n;
    if num_equiv == 0
        k = 1;
        while num_equiv == 0
            n = n * k;  % Compute factorial k!
            num_equiv = num_equiv + (subs(diff(num, k), x, x0) * (x - x0)^k) / n;
            k = k + 1;
        end
    end

    % Handle denominator
    k = 0;
    n = 1;
    den_equiv = (subs(diff(den, k), x, x0) * (x - x0)^k) / n;
    if den_equiv == 0
        k = 1;
        while den_equiv == 0
            n = n * k;  % Compute factorial k!
            den_equiv = den_equiv + (subs(diff(den, k), x, x0) * (x - x0)^k) / n;
            k = k + 1;
        end
    end

    lim = num_equiv / den_equiv;
    lim = subs(lim, x, x0);
    lim = double(lim);

    text = ['The value of the limit is: ' num2str(lim)];
    disp(text)
else
    disp('The limit is not in 0/0 indeterminate form')
end
end
