function taylor2
syms x
f=input('input f(x)= ');
x0=input('input x0= ');
if limit(f,x,x0)==0
k=0;
n=1;
taylor=(subs(diff(f,k),x,x0)*(x-x0)^k)/n;
if taylor==0
    k=1;
    while taylor==0
       n=n*k;     %factorial (k!)
       taylor=taylor+((subs(diff(f,k),x,x0)*(x-x0)^k))/n;
       k=k+1;
    end
end
disp('The lowest-order nonzero term in the Taylor expansion is:')
disp(taylor)
text=['The order of this term is: ' num2str(k-1)];
disp(text);
ezplot(f)
else
    disp('f(x) is not infinitesimally small at x0')
end
end
