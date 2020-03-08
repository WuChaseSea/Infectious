function MyModelSIR(N, I, r, b, c)
%MYMODELSIR 此处显示有关此函数的摘要
%   SIR模型的模拟
%   N 总人口数
%   I 已感染者（病人）
%   S 易感染者（健康者）
%   R 移出者（康复者）
%   r 已感染者每天会接触的健康者数目
%   b 健康者被接触之后被感染的概率
%   c 感染者被治好的概率
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
xlabel("天");ylabel("人数");
legend("易感染者（健康）","已感染者（病人）","移出者（康复者）");
title("SIR模型");
end

