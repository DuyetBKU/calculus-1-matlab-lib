function integral6
syms x
f = input('Enter function f(x) = ');
disp('Enter the interval [a, b]')
a = input('a = ');
b = input('b = ');
[~, denom] = numden(f);  % Extract denominator
singularities = [];
if ~isreal(denom)
   singularities = solve(denom);
   singularities = double(singularities);
   i = 1;
   while i <= length(singularities)
     if abs(imag(singularities(i))) > 1e-5 || singularities(i) < a || singularities(i) > b
         singularities(i,:) = [];
         i = i - 1;
     else
         singularities(i) = singularities(i) - imag(singularities(i)) * 1i;
     end
     i = i + 1;
   end
   singularities = union(singularities, singularities);
end
if isempty(singularities) && ~isinf(a) && ~isinf(b)
    disp('The integral of f is a regular (proper) integral')
elseif ~isempty(singularities) && ~isinf(a) && ~isinf(b)
    disp('The integral of f is an improper integral of the second kind')
elseif isempty(singularities) && (isinf(a) || isinf(b))
    disp('The integral of f is an improper integral of the first kind')
else
    disp('The integral of f is an improper integral of both first and second kinds')
end
singularities = [a; singularities; b];
singularities = union(singularities, singularities);
S = 0;
for i = 1:length(singularities)-1
    S = S + abs(int(f, x, singularities(i), singularities(i+1)));
end
if isreal(S)
    S = double(S);
    text = ['The integral of f is convergent and equals: ' num2str(S)];
    disp(text)
else
    text = 'The integral of f is divergent (improper integral)';
    disp(text)
end
ezplot(f)
end
