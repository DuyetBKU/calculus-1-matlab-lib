function taylor
syms x
f=input('nhap f(x)= ');
x0=input('nhap x0= ');
a=input('nhap so bac cua khai trien taylor: ');
k=0;
n=1;
taylor=(subs(diff(f,k),x,x0)*(x-x0)^k)/n;
taylor=double(taylor);
if abs(taylor)<0.000001
    taylor=0;
end
k=1;
while k<=a
    n=n*k;     %tinh giai thua (k!)
    if abs(subs(diff(f,k),x,x0))>0.0000001
      taylor=taylor+((subs(diff(f,k),x,x0)*(x-x0)^k))/n;
    end
      k=k+1;
end
disp('khai trien taylor cua f la')
disp(taylor)
end
