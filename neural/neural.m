fid = fopen('file1.txt');
N1=946;
out1=textscan(fid,'%f',N1);
fclose(fid);
for i=[1:1:3*N1/4]
    input(i)=i;
   target(i)=out{1}(i);
end
N1=i;