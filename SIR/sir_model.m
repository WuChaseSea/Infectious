function sir_model(filename)
%SIR_MODEL �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   ��ȡ�ļ�
my_data = readMyData(filename);
[r , ~] = size(my_data);
mydata = zeros(r, 6);
for i = 1:r
    for j = 1:6
        mydata(i,j) = my_data{i,j}(1);
    end
end
I = (mydata(:, 3) - mydata(:, 5) - mydata(:,6));  % ��������
R = mydata(:, 5) + mydata(:, 6);
I_m = zeros(r, 1);
S_m = zeros(r, 1);
R_m = zeros(r, 1); % ģ����Ƴ���
a = 0.01; % �Ƴ�ǿ��
b = 2.08e-5; % ��Ⱦǿ��
S0 = 19900; 
I_m(1) = I(1);
S_m(1) = S0;
R_m(1) = R(1);
for iday=2:1:r
    I_m(iday) = I_m(iday-1)+b*S_m(iday-1)*I_m(iday-1)-a*I_m(iday-1);
    S_m(iday) = S_m(iday-1)-b*S_m(iday-1)*I_m(iday-1);
    R_m(iday) = R_m(iday-1)+a*I_m(iday-1);
end
%   ����ע�Ͳ����ǻ���ԭʼ������ͼ
figure;
plot(1:r,I,'r*',1:r,R,'bo',1:r,I_m,1:r,R_m);
grid on;
xlabel("��");ylabel("����");
legend("ȷ������","�Ƴ�����","ȷ��ģ��","�Ƴ�ģ��");
title("SIR");
Bas = zeros(r,1);
for bas_tmp=1:1:r
    Bas(bas_tmp)=S_m(bas_tmp)*b/a;
end
figure;
plot(1:r,Bas)
grid minor;
xlabel("��");ylabel("��С");
title("����������")
end

