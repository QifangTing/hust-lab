% design4_3.m
%      s + 1
% --------------
%  s^2 + s + 1

syms s;
fs=sym((s+1)/(s^2+s+1))  %ϵͳ���ݺ������ű���ʽ
ft=ilaplace(fs);
ft=maple('convert',ft,'radical');
figure
ezplot(ft,[0,pi])
title('ʱ��ԭ����f(t)');