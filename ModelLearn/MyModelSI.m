function MyModelSI(N, I, r, b)
%MYMODELSI �˴���ʾ�йش˺�����ժҪ
%   SIģ�͵�ģ��
%   N ���˿���
%   I �Ѹ�Ⱦ�ߣ����ˣ�
%   S �׸�Ⱦ�ߣ������ߣ�
%   r �Ѹ�Ⱦ��ÿ���Ӵ��Ľ�������Ŀ
%   b �����߱��Ӵ�֮�󱻸�Ⱦ�ĸ���
S=N-I;
T=1:200;
for idx=1:length(T)-1
    S(idx+1)=S(idx)-r*b*S(idx)*I(idx)/N;
    I(idx+1)=I(idx)+r*b*S(idx)*I(idx)/N;
end
figure;
plot(T,S,T,I);grid on;
xlabel("��");ylabel("����");
legend("�׸�Ⱦ�ߣ�������","�Ѹ�Ⱦ�ߣ����ˣ�");
title("SIģ��");
end

