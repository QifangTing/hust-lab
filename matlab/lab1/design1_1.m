%  design1_1.m
t = 0:0.01:4; % ʱ��������ʼ��Ϊ 0,ȡ����� 0.1,ȡ������ 2*pi
ty = 0:0.01:8;
x=exp(-1*t).*(Heaviside(t)-Heaviside(t-2));
h=2*(Heaviside(t)-Heaviside(t-2));
y=conv(x,h)*dt;  % ������
figure
subplot(3,1,1);  % ����ͼ��ʾ����ͼ�ο��Ϊ 3x1 ����ͼ��1����ͼ��ʾ x
plot(t,x)
ylabel('���뼤��');
subplot(3,1,2);  % 2����ͼ��ʾ h
plot(t,h)
ylabel('��λ�弤��Ӧ');
subplot(3,1,3);  % 3����ͼ��ʾ y
plot(ty,y);
ylabel('�����Ӧ');
