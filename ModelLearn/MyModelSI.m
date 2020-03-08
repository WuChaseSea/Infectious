function MyModelSI(N, I, r, b)
%MYMODELSI 此处显示有关此函数的摘要
%   SI模型的模拟
%   N 总人口数
%   I 已感染者（病人）
%   S 易感染者（健康者）
%   r 已感染者每天会接触的健康者数目
%   b 健康者被接触之后被感染的概率
S=N-I;
T=1:200;
for idx=1:length(T)-1
    S(idx+1)=S(idx)-r*b*S(idx)*I(idx)/N;
    I(idx+1)=I(idx)+r*b*S(idx)*I(idx)/N;
end
figure;
plot(T,S,T,I);grid on;
xlabel("天");ylabel("人数");
legend("易感染者（健康）","已感染者（病人）");
title("SI模型");
end

