fid = fopen('file.txt');
N=fscanf(fid,'%u',1);
ON=N;
out=textscan(fid,'%f',N);
fclose(fid);
series=out{1};
series1=series;
time=[1:1:N];
figure,plot(time,series)
[ p ]=Autocorrelation(series,N);
k=[0:1:N-1];
figure,plot(k,p)
m=mean(series);
s=std(series);
series=(series-m)/s;
figure,plot(time,series)
[ p ]=Autocorrelation(series,N);
figure,plot(k,p)
N=int64(3*ON/4);
nseries=series(1:N);
tseries=series(N+1:ON);
iseries=series(1:N/2);
id=IDDATA(iseries);
model=parameter_estimate(id);
maxlike=0;
for p=1:6
    for q=0:2
         for i=1:q
                e(i)=0.0;
                e2(i)=0.0;
         end
            sum1=0.0;
            for i=q+1:N
                k=2;
                sum=0.0;
                j=i-1;
                while j>=i-p
                    if j>0
                        sum=sum-model(p,q+1).A(k)*series(j);
                    end
                    k=k+1;
                    j=j-1;
                end
                k=2;
                j=i-1;
                while j>=i-q
                    if j>0
                        sum=sum+model(p,q+1).C(k)*e(j);
                    end
                    k=k+1;
                    j=j-1;
                end
                e(i)=series(i)-sum;
                e2(i)=e(i)*e(i);
                if i>=N/2
                    sum1=sum+e2(i);
                end
            end
            e1=e(N/2+1:N);
            e2=e2(N/2+1:N);
            mse=2*sum1/N;
          like=-(N/2)*log(std(e1))-p-q;
          if p==1 && q==0
              mxlike=like;
              msemin=mse;
              msep=1;
              mseq=0;
              rp=1;
              rq=0;
          end
          if maxlike<=like
                  maxlike=like;
                  rp=p;
                  rq=q;
                  e3=e;
          end 
          if msemin>mse
              msemin=mse;
              msep=p;
              mseq=q;
              e4=e;
          end
    end
end
model1=model(rp,rq+1);
for i=N+1:1:ON
    k=2;
    sum=0.0;
    j=i-1;
    while j>=i-rp
        if j>0
            sum=sum-model(rp,rq+1).A(k)*series(j);
        end
        k=k+1;
        j=j-1;
    end
    k=2;
    j=i-1;
    while j>=i-rq
        if j>0
            sum=sum+model(rp,rq+1).C(k)*e3(j);
        end
        k=k+1;
        j=j-1;
    end
    e3(i)=series(i)-sum;
    forecast(i)=sum;
end
%figure,plot(time,forecast);
figure,plot(time,e3);
for i=N+1:ON
    k=2;
    sum=0.0;
    j=i-1;
    while j>=i-msep
        if j>0
            sum=sum-model(msep,mseq+1).A(k)*series(j);
        end
        k=k+1;
        j=j-1;
    end
    k=2;
    j=i-1;
    while j>=i-mseq
        if j>0
            sum=sum+model(msep,mseq+1).C(k)*e4(j);
        end
        k=k+1;
        j=j-1;
    end
    e4(i)=series(i)-sum;
    forecast1(i)=sum;
end
%figure,plot(time,forecast1);
%figure,plot(time,e4);
forecast=forecast*s+m;
figure,plot(time,forecast);
forecast1=forecast1*s+m;
%error calc
error3=0.0;
sum=0.0;
for i=N+1:ON
    error3=error3+abs(forecast(i)-series1(i));
    sum=sum+series1(i);
end
e=transpose(e);
e3=transpose(e3);
error3=abs(error3)/sum*100;
error4=abs((forecast(N+1)-series1(N+1)))*100/series1(N+1);

    




    


