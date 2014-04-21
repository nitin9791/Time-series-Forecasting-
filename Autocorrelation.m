function [ p ] = Autocorrelation( series,N )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
 m=mean(series);
    for k =0:1:N-1
        t=1;
        sum=0.0;
        while t+k<=N
            sum = sum+(series(t)-m)*(series(t+k)-m);
            t=t+1;
        end
            sum=sum/N;
        if k==0
            p(1)=1.0;
        else
            p(k+1)=sum/p(1);
        end
    end

end

