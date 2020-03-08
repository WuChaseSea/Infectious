function MyModelSIR(N, I, r, b, c)
%MYMODELSIR �˴���ʾ�йش˺�����ժҪ
%   SIRģ�͵�ģ��
%   N ���˿���
%   I �Ѹ�Ⱦ�ߣ����ˣ�
%   S �׸�Ⱦ�ߣ������ߣ�
%   R �Ƴ��ߣ������ߣ�
%   r �Ѹ�Ⱦ��ÿ���Ӵ��Ľ�������Ŀ
%   b �����߱��Ӵ�֮�󱻸�Ⱦ�ĸ���
%   c ��Ⱦ�߱��κõĸ���
S=N-I;
R=0;
T=1:100;
for idx=1:length(T)-1
    S(idx+1)=S(idx)-r*b*S(idx)*I(idx)/N;
    I(idx+1)=I(idx)+r*b*S(idx)*I(idx)/N-I(idx)*c;
    R(idx+1)=R(idx)+I(idx)*c;
end
figure;
plot(T,S,T,I,T,R);grid on;
xlabel("��");ylabel("����");
legend("�׸�Ⱦ�ߣ�������","�Ѹ�Ⱦ�ߣ����ˣ�","�Ƴ��ߣ������ߣ�");
title("SIRģ��");
end

