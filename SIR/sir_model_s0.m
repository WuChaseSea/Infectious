function sir_model_s0(filename)
%SIR_MODEL 此处显示有关此函数的摘要
%   此处显示详细说明
%   读取文件
my_data = read_file_new(filename);
[r , ~] = size(my_data);
mydata = zeros(r, 5);
for i = 1:r
    for j = 1:5
        mydata(i,j) = my_data{i,j};
    end
end
I = (mydata(:, 2) - mydata(:, 4) - mydata(:,5));  % 患病人数
R = mydata(:, 4) + mydata(:, 5);
%   下面注释部分是画最原始的数据图
% figure;
% grid on;
% plot(1:r,I,'r*',1:r,R,'bo');
% xlabel("天");ylabel("人数");
% legend("确诊数据","移出数据");
% title("实时数据");
% % I_m = zeros(r, 1); % 模拟的感染者
% % S_m = zeros(r, 1); % 模拟的健康者
R_m = zeros(r, 1); % 模拟的移出者
S0 = 19900; % a表示移出强度
b_t = (2.0e-5:(1.0e-4 - 2.0e-5)/100:1.0e-4); % b表示感染强度
a_t = (0.01:(0.8 - 0.01)/100:0.8); % S0表示最初的健康者
[b, a] = meshgrid(b_t, a_t);
% I_m(1) = I(1);
SSE_D = zeros(101,101);
for count_tmp_a = 1:1:101
    for count_tmp_b = 1:1:101
        I_m = zeros(r, 1); % 模拟的感染者
        S_m = zeros(r, 1); % 模拟的健康者
        I_m(1) = I(1);
        S_m(1) = S0;
        b_tmp = b(1, count_tmp_b);
        a_tmp = a(count_tmp_a, 1);
        for s_i_tmp=2:1:r
            I_m(s_i_tmp) = I_m(s_i_tmp-1) + b_tmp*S_m(s_i_tmp-1)*I_m(s_i_tmp-1)-a_tmp*I_m(s_i_tmp-1);
            S_m(s_i_tmp) = S_m(s_i_tmp-1) - b_tmp*S_m(s_i_tmp-1)*I_m(s_i_tmp-1); 
        end
        SSE = zeros(r,1);
        for sse_tmp=1:1:r
            SSE(sse_tmp) = (I_m(sse_tmp)-I(sse_tmp))^2;
        end
        SSE_D(count_tmp_a, count_tmp_b) = sum(SSE)/10^5;
    end
end
% S_m(1) = S0;
% for s_i_tmp=2:1:r
%     I_m(s_i_tmp) = I_m(s_i_tmp-1) + b*S_m(s_i_tmp-1)*I_m(s_i_tmp-1)-a*I_m(s_i_tmp-1);
%     S_m(s_i_tmp) = S_m(s_i_tmp-1) - b*S_m(s_i_tmp-1)*I_m(s_i_tmp-1); 
% end
% SSE = zeros(r,1);
% for sse_tmp=1:1:r
%     SSE(sse_tmp) = (I_m(sse_tmp)-I(sse_tmp))^2;
% end
% SSE_D = sum(SSE);
figure;
mesh(b, a, SSE_D);
figure;
contour(b, a, SSE_D);
% mesh(b, S0, SSE_D);
end

