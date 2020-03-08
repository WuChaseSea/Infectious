function data1 = readMyData(file)
%READMYDATA 此处显示有关此函数的摘要
%   此处显示详细说明
f = fopen(file);
data_tmp = textscan(f,'%d-%d-%d %d:%d:%d    %d    %d    %d    %d    %d');
[r c]= size(data_tmp{1,2});
data1 = cell(r,6);
for i=1:r
    data1{i,1}=strcat(num2str(data_tmp{1,2}(i,1)),'-',num2str(data_tmp{1,3}(i,1)));
    data1{i,2}=data_tmp{1,7}(i,1);
    data1{i,3}=data_tmp{1,8}(i,1);
    data1{i,4}=data_tmp{1,9}(i,1);
    data1{i,5}=data_tmp{1,10}(i,1);
    data1{i,6}=data_tmp{1,11}(i,1);
end
end

