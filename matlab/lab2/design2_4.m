% design2_4.m

sym t;
f=sym('(1-abs(t))*(Heaviside(t+1)-Heaviside(t-1))');  % �źŵķ��ű���ʽ
F=fourier(f);  % �õ� Fourier �任�ķ��ű���ʽ
FF=maple('convert',F,'piecewise');  % �� Fourier �任�ķ��ű���ʽ����ת����ʹ����ڻ�ͼ
FFF=abs(FF);  % �õ�Ƶ�׷��ű���ʽ
figure
subplot(1,2,1)
ezplot(f,[-pi,pi])
title('ʱ���� f(t)');
subplot(1,2,2)
ezplot(FFF,[-8*pi,8*pi])
title('Ƶ���� F(jw)');