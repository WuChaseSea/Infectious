function I_image = ModelSIR(filename, day)
%MODELSIR 此处显示有关此函数的摘要
%   此处显示详细说明
% 将前day天的数据存入矩阵中
my_data = readMyData(filename);
[r c] = size(my_data);
mydata = zeros(day, 6);
for i = 1:r
    for j = 1:6
        mydata(i,j) = my_data{i,j}(1);
    end
end
% 设置
N = 1e6;
I = (mydata(:, 3) - mydata(:, 5) - mydata(:,6));       %患病人数比例
It = max(r,day);
I_m = zeros(It,1);
I_m(1) = I(1);
S = N - I;      %易感染人群比例
S_m = zeros(It,1);
S_m(1) = S(1);
RD = (mydata(:, 5) + mydata(:,6)); %治愈和死亡比例
RD_m = zeros(It,1);
RD_m(1) = RD(1);
% 每天新增病人数
Addill = zeros(r,1);
Addill(1) = 0;
for k = 1:1:r-1
    Addill(k+1) = mydata(k+1, 2) - mydata(k, 2);
end
tmp = zeros(r,1);
for tt=2:1:r
    tmp(tt) = Addill(tt)/I(tt-1);
end
lamda = tmp(1:r);
% 
Addrd = zeros(r,1);
Addrd(1) = 0;
for k = 1:1:r-1
    Addrd(k+1) = RD(k+1, 1) - RD(k, 1);
end
tmp_rd = zeros(r,1);
for tt=2:1:r
    tmp_rd(tt) = Addrd(tt)/I(tt-1);
end
lamda_rd = tmp_rd(1:r);
%
%
Adds = zeros(r,1);
Adds(1) = 0;
for s = 1:1:r-1
    Adds(s+1) = S(s+1,1) - S(s,1);
end
tmp_s = zeros(r,1);
for ts = 2:1:r
    tmp_s(ts) = (-Adds(ts)*N)/(S(ts-1)*I(ts-1));
end
lamda_s = tmp_s(1:r);
%
[lamdap , ~] = polyfit((1:r)',lamda,4);
[lamdap_rd , ~] = polyfit((1:r)',lamda_rd,4);
[lamdap_s , ~] = polyfit((1:r)',lamda_s,4);
yi_b = zeros(r-1,1);
yi_rd = zeros(r-1,1);
yi_s = zeros(r-1,1);
% yi_b没什么用
if day <= 45
    for iy=2:1:r
        yi_b(iy)=lamdap(1)*iy^4 + lamdap(2)*iy^3 + lamdap(3)*iy^2 + lamdap(4)*iy + lamdap(5);
        yi_rd(iy)=lamdap_rd(1)*iy^4 + lamdap_rd(2)*iy^3 + lamdap_rd(3)*iy^2 + lamdap_rd(4)*iy + lamdap_rd(5);
        yi_s(iy)=lamdap_s(1)*iy^4 + lamdap_s(2)*iy^3 + lamdap_s(3)*iy^2 + lamdap_s(4)*iy + lamdap_s(5);
    end
else
    for iy=2:1:day
        yi_b(iy)=lamdap(1)*iy^4 + lamdap(2)*iy^3 + lamdap(3)*iy^2 + lamdap(4)*iy + lamdap(5);
        yi_rd(iy)=lamdap_rd(1)*iy^4 + lamdap_rd(2)*iy^3 + lamdap_rd(3)*iy^2 + lamdap_rd(4)*iy + lamdap_rd(5);
        yi_s(iy)=lamdap_s(1)*iy^4 + lamdap_s(2)*iy^3 + lamdap_s(3)*iy^2 + lamdap_s(4)*iy + lamdap_s(5);
    end
end
for idx=2:1:max(r,day)
    S_m(idx) = S_m(idx-1) - yi_s(idx)*I_m(idx-1)*S_m(idx-1)/N;
    %I_m(idx) = I_m(idx-1)+yi_b(idx)*I_m(idx-1)-yi_rd(idx)*RD_m(idx-1);
    I_m(idx) = I_m(idx-1)+yi_s(idx)*I_m(idx-1)*S_m(idx-1)/N - yi_rd(idx-1)*I_m(idx-1);
    RD_m(idx) = RD_m(idx-1) + yi_rd(idx)*I_m(idx-1);
end
% 以下注释部分为验证那个参数的模拟是否正确
% figure;
% p=polyfit([1:r]',lamda_s(1:r),6);
% yy = polyval(p,1:day);
% plot(1:r,lamda_s(1:r),1:day,yy(1:day));
figure;
if day <= 45
    plot(1:r,I(1:r),'r*',1:r,I_m(1:r),1:r,RD(1:r),'b*',1:r,RD_m(1:r));
else
    plot(1:r,I(1:r),'r*',1:day,I_m(1:day),1:r,RD(1:r),'b*',1:r,RD_m(1:r));
end
grid on;
xlabel("天");ylabel("人数");
legend("确诊数据","确诊模拟","移出数据","移出模拟")
title("SIR");
Bas = zeros(r,1);
for bas_tmp=1:1:r
    Bas(bas_tmp)=yi_s(bas_tmp)/yi_b(bas_tmp);
end
figure;
plot(1:r,Bas)
grid minor;
xlabel("天");ylabel("大小");
title("基础再生数")
% [b,bint,r,rint,stats] = regress(I,I_m);
% rcoplot(r,rint);
end
