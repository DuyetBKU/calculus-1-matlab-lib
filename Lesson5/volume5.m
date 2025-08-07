function thetich5
syms x
f1 = input('Enter function f1(x) = ');
f2 = input('Enter function f2(x) = ');
set(ezplot(char(f1), [-20, 20, -20, 20]), 'Color', 'blue', 'LineWidth', 1);
hold on
set(ezplot(char(f2), [-20, 20, -20, 20]), 'Color', 'blue', 'LineWidth', 1);
hold off
m = solve(f1 - f2, x);
m = union(m, m);  % Remove duplicate solutions
m = double(m);
j = 1;
while j <= length(m)
    if abs(imag(m(j))) > 0.0001  % If imaginary part > 0.0001, discard
        m(j) = [];
        j = j - 1;
    else
        m(j) = m(j) - imag(m(j)) * 1i;  % Keep only real part
    end
    j = j + 1;
end
if ~isempty(m)
    disp('Intersection points of the two graphs:')
    for j = 1:length(m)
        disp(['(' num2str(m(j)) ', ' num2str(subs(f1, x, m(j))) ')'])
    end
end
if length(m) > 2
    disp('f1 and f2 have more than 2 intersection points')
elseif length(m) < 2
    disp('f1 and f2 have less than 2 intersection points')
else
    if 0 < max(m) && 0 > min(m)
        disp('The region D lies on both sides of the y-axis')
        return
    end
    V = 2 * pi * abs(int(x * f1 - x * f2, x, min(m), max(m)));
    V = double(V);
    text = ['Volume of revolution V = ' num2str(V)];
    disp(text)
end
end
