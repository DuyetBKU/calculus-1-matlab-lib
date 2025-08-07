### 💻 Explanation of each command line:
```matlab
function partialFraction         % Define the function named partialFraction
syms x                           % Declare x as a symbolic variable

f = input('Enter the function f = ');                     % Prompt user to input a symbolic expression f(x)
[num, den] = numden(f);                                   % Extract numerator and denominator of f

num = sym2poly(num);                                      % Convert numerator to a vector of polynomial coefficients
den = sym2poly(den);                                      % Convert denominator to a vector of polynomial coefficients

[a, b, c] = residue(num, den);                            % Perform partial fraction decomposition: a/(x-b) + ... + c(x)

[n, ~] = size(a);                                         % Get number of residues (terms)
k = 1;                                                    % Initialize counter for complex conjugate terms
i = 1;                                                    % Initialize index for looping through residues

while i <= n                                              % Loop through each residue
   if imag(a(i,1)) ~= 0 || imag(b(i,1)) ~= 0              % If either residue or pole is complex
       g = a(i,1)/(x - b(i,1));                           % Form the complex term g
       h = a(i+1,1)/(x - b(i+1,1));                       % Form its conjugate h
       l = g + h;                                         % Sum of complex conjugates (should be real)
       [t(k,1), m(k,1)] = numden(l);                      % Get numerator and denominator of real result
       a(i,:) = [];                                       % Remove complex residue a(i)
       a(i,:) = [];                                       % Remove conjugate residue a(i+1)
       b(i,:) = [];                                       % Remove complex pole b(i)
       b(i,:) = [];                                       % Remove conjugate pole b(i+1)
       n = n - 2;                                         % Update number of terms after removing 2
       k = k + 1;                                         % Increment counter of real terms from complex parts
   else
       i = i + 1;                                         % Otherwise, move to next term
   end
end

if ~isempty(c)                                            % If there’s a non-zero polynomial part
    j = length(c);                                        % Get its degree
    y = 0;                                                % Initialize y for constructing the polynomial
    y = sym(y);
    for i = 1:j
        y = y + c(i)*x^(j - i);                           % Reconstruct the direct polynomial part from coefficients
    end
    text = ['Direct polynomial part = ' char(y)];         % Prepare display text for direct part
else
    text = ('Direct polynomial part = 0');                % If no polynomial part, show zero
end

[q, ~] = size(a);                                         % Update number of real residue terms
if k == 1                                                 % If no complex terms were combined
    j = 1;
    for i = 1:q
        if i == 1
            j = 1;
        elseif b(i,1) == b(i-1,1)
            j = j + 1;                                    % Track multiplicity of repeated poles
        else
            j = 1;
        end
        if a(i,1) ~= 0
            % Append term in the form a / (x - b)^j to the display text
            text = [text ' + (' char(num2str(a(i,1)) / (x - num2str(b(i,1)))^j) ')'];
        end
    end
end

if k ~= 1                                                 % If complex conjugate terms were found
    j = 1;
    for i = 1:q
        if i == 1
            j = 1;
        elseif b(i,1) == b(i-1,1)
            j = j + 1;                                    % Handle repeated real poles
        else
            j = 1;
        end
        if a(i,1) ~= 0
            % Append real fraction terms a / (x - b)^j
            text = [text ' + (' char(num2str(a(i,1)) / (x - num2str(b(i,1)))^j) ')'];
        end
    end
    for i = 1:k - 1
        % Append the reconstructed real expressions from complex terms
        text = [text ' + (' char(t(i,1)) ')/(' char(m(i,1)) ')'];
    end
end

disp(text)                                                % Display the final partial fraction decomposition
end                                                       % End of function
