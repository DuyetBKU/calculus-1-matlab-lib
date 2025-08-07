function thetich
syms x
f1 = input('Enter function f1(x) = ');
f2 = input('Enter function f2(x) = ');
ezplot(f1);
hold on
ezplot(f2);
hold off
m = solve(f1 - f2, x);
m = union(m, m);  % Remove duplicate solutions
m = double(m);
i = 1;
while i <= length(m)
    if abs(imag(m(i))) > 0.0001  % If imaginary part is too large, discard
        m(i) = [];
        i = i - 1;
    else
        m(i) = m(i) - imag(m(i)) * 1i;  % Keep only real part
    end
    i = i + 1;
end
if ~isempty(m)
    disp('Intersection points of the two graphs are:')
    for j = 1:length(m)
        disp(['(' num2str(m(j)) ', ' num2str(subs(f1, x, m(j))) ')'])
    end
end
if length(m) > 2
    disp('f1 and f2 have more than 2 intersection points')
elseif length(m) < 2
    disp('f1 and f2 have less than 2 intersection points')
else
    warning off  % Suppress symbolic warnings
    n = union([solve(f1); solve(f2)], [solve(f1); solve(f2)]);
    i = 1;
    while i <= length(n)
        if ~isreal(n(i))
            n(i) = [];
            i = i - 1;
        end
        i = i + 1;
    end

    n = double(n);
    for i = 1:length(n)
        if n(i) < max(m) && n(i) > min(m)
            disp('There is an x-intercept within the region between the curves')
            return
        end
    end
    V = pi * abs( int(f1^2, x, min(m), max(m)) - int(f2^2, x, min(m), max(m)) );
    V = double(V);
    text = ['Volume of revolution V = ' num2str(V)];
    disp(text)
end
end
