function MyModelSIS(N, I, r, b, c)
%MYMODELSIs �˴���ʾ�йش˺�����ժҪ
%   SISģ�͵�ģ��
%   N ���˿���
%   I �Ѹ�Ⱦ�ߣ����ˣ�
%   S �׸�Ⱦ�ߣ������ߣ�
%   r �Ѹ�Ⱦ��ÿ���Ӵ��Ľ�������Ŀ
%   b �����߱��Ӵ�֮�󱻸�Ⱦ�ĸ���
%   c ��Ⱦ�߱��κõĸ���
S=N-I;
T=1:200;
for idx=1:length(T)-1
    S(idx+1)=S(idx)-r*b*S(idx)*I(idx)/N+I(idx)*c;
    I(idx+1)=I(idx)+r*b*S(idx)*I(idx)/N-I(idx)*c;
end
figure;
plot(T,S,T,I);grid on;
xlabel("��");ylabel("����");
legend("�׸�Ⱦ�ߣ�������","�Ѹ�Ⱦ�ߣ����ˣ�");
title("SISģ��");
end

