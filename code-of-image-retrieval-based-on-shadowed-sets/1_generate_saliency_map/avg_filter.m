function d=avg_filter(x,n)   
a(1:n,1:n)=1;   
[hight, width]=size(x); 
x1=double(x);
x2=x1;
for i=1:hight-n+1
    for j=1:width-n+1
        c=x1(i:i+(n-1),j:j+(n-1)).*a;
        disp(j);
        s=sum(sum(c));                
        x2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); 
    end
end
d=uint8(x2);