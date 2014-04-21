function [ model ] = parameter_estimate( id )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    for i=1:1:6
        for j=0:1:2
            M=armax(id,[i,j]);
            [A,B,C,D,F]=polydata(M);
            model(i,j+1).A=A;
            model(i,j+1).C=C;
        end
    end
end