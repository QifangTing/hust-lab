% design2_5.m

sym t;
f=sym('exp(-1*t)*Heaviside(t)');  % �źŵķ��ű��ʽ
F=fourier(f);  % �õ� Fourier �任�ķ��ű��ʽ
FF=maple('convert',F,'piecewise');  % �� Fourier �任�ķ��ű��ʽ����ת����ʹ����ڻ�ͼ
FFF=abs(FF);  % �õ�Ƶ�׷��ű��ʽ
figure
subplot(1,2,1)
ezplot(f,[-10*pi,10*pi])
title('ʱ���� f(t)');
subplot(1,2,2)
ezplot(FFF,[-pi,pi])
title('Ƶ���� F(jw)');