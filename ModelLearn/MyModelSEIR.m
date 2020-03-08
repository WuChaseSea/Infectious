function MyModelSEIR(N, I, r, b, c,a)
%MYMODELSEIR �˴���ʾ�йش˺�����ժҪ
%   SEIRģ�͵�ģ��
%   N ���˿���
%   I �Ѹ�Ⱦ�ߣ����ˣ�
%   S �׸�Ⱦ�ߣ������ߣ�
%   E Ǳ����
%   R �Ƴ��ߣ������ߣ�
%   r �Ѹ�Ⱦ��ÿ���Ӵ��Ľ�������Ŀ
%   b �����߱��Ӵ�֮�󱻸�Ⱦ�ĸ���
%   c ��Ⱦ�߱��κõĸ���
%   a Ǳ����ת��Ϊ��Ⱦ�ߵĸ���
S=N-I;
R=0;
E=0;
T=1:140;
for idx=1:length(T)-1
    S(idx+1)=S(idx)-r*b*S(idx)*I(idx)/N;
    E(idx+1)=E(idx)+r*b*S(idx)*I(idx)/N-a*E(idx);
    I(idx+1)=I(idx)+a*E(idx)-I(idx)*c;
    R(idx+1)=R(idx)+I(idx)*c;
end
figure;
plot(T,S,T,I,T,R,T,E);grid on;
xlabel("��");ylabel("����");
legend("�׸�Ⱦ�ߣ�������","�Ѹ�Ⱦ�ߣ����ˣ�","�Ƴ��ߣ������ߣ�","Ǳ����");
title("SEIRģ��");
end

