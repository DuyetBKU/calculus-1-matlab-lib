function tichphan
syms x
f=input('nhap ham f1(x)= ');
g=input('nhap ham f2(x)= ');
m=solve(char(f-g),x);
m=double(m);
i=1;
while i<=length(m)
    if imag(m(i))>0.0001
        m(i)=[];
        i=i-1;
    else
        m(i)=m(i)-imag(m(i))*1i;
    end
    i=i+1;
end
m=union(m,m);
if length(m)<=1
  disp('ham f1 va f2 co it hon 2 giao diem, khong the tich the tich')
else
  t=0;
 for i=1:length(m)-1
  t=t+abs(int(f-g,x,m(i),m(i+1)));
 end
 t=double(t);
 text=['dien tich hinh phang bang: ' num2str(t)];
 disp(text)
end
ezplot(f)
hold on
ezplot(g)
hold off
end
