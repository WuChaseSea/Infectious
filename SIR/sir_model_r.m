function sir_model(filename)
%SIR_MODEL �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   ��ȡ�ļ�
my_data = read_file_new(filename);
[r , ~] = size(my_data);
mydata = zeros(r, 5);
for i = 1:r
    for j = 1:5
        mydata(i,j) = my_data{i,j};
    end
end
I = (mydata(:, 2) - mydata(:, 4) - mydata(:,5));  % ��������
R = mydata(:, 4) + mydata(:, 5);
%   ����ע�Ͳ����ǻ���ԭʼ������ͼ
% figure;
% grid on;
% plot(1:r,I,'r*',1:r,R,'bo');
% xlabel("��");ylabel("����");
% legend("ȷ������","�Ƴ�����");
% title("ʵʱ����");
a = 0.05; % a��ʾ�Ƴ�ǿ��
b_t = (2.0e-5:(1.0e-4 - 2.0e-5)/100:1.0e-4); % b��ʾ��Ⱦǿ��
S0_t = (1.0e4:(1.0e6 - 1.0e4)/100:1.0e6); % S0��ʾ����Ľ�����
[b, S0] = meshgrid(b_t, S0_t);
% I_m(1) = I(1);
SSE_D = zeros(101,101);
for count_tmp_s0 = 1:1:101
    for count_tmp_b = 1:1:101
        I_m = zeros(r, 1); % ģ��ĸ�Ⱦ��
        S_m = zeros(r, 1); % ģ��Ľ�����
        R_m = zeros(r, 1); % ģ����Ƴ���
        R_m(1) = R(1);
        I_m(1) = I(1);
        S_m(1) = S0(count_tmp_s0, 1);
        b_tmp = b(1, count_tmp_b);
        for s_i_tmp=2:1:r
            I_m(s_i_tmp) = I_m(s_i_tmp-1) + b_tmp*S_m(s_i_tmp-1)*I_m(s_i_tmp-1)-a*I_m(s_i_tmp-1);
            S_m(s_i_tmp) = S_m(s_i_tmp-1) - b_tmp*S_m(s_i_tmp-1)*I_m(s_i_tmp-1); 
            R_m(s_i_tmp) = R_m(s_i_tmp-1) + a*I_m(s_i_tmp-1);
        end
        SSE = zeros(r,1);
        sse_dis = 0;
        for sse_tmp=1:1:r
            SSE(sse_tmp) = (I_m(sse_tmp)-I(sse_tmp))^2+(R_m(sse_tmp)-R(sse_tmp))^2;
            sse_dis = sse_dis + SSE(sse_tmp);
        end
%         SSE_D(count_tmp_s0, count_tmp_b) = sse_dis;
        SSE_D(count_tmp_s0, count_tmp_b) = sum(SSE);
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
mesh(b, S0, SSE_D);
figure;
contour(b, S0, SSE_D);
% mesh(b, S0, SSE_D);
end

