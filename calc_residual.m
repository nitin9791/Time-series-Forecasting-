function [ e ] = calc_residual( model,p,q,N,series)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    for i=1:q
        e(i)=0.0;
    end
    for i=q+1:N
        k=2;
        sum=0.0;
        for j=i-1;-1;i-p
            if j>0
                sum=sum-model.A(k)*series(j);
            end
            k=k+1;
        end
        k=2;
        for j=i-1;-1;i-q
            sum=sum+model.C(k)*e(j);
            k=k+1;
        end
        e(i)=series(i)-sum;
end

