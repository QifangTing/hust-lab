%  design1_2.m
tx = -4:0.01:4; % ʱ��������ʼ��Ϊ 0,ȡ����� 0.1,ȡ������ 2*pi
th = -4:0.01:4;
ty = -8:0.01:8;
x=(1-abs(tx)/4).*(Heaviside(tx+4)-Heaviside(tx-4));
h=Heaviside(th);
y=conv(x,h)*0.01;  % ������
figure
subplot(3,1,1);  % ����ͼ��ʾ����ͼ�ο��Ϊ 3x1 ����ͼ��1����ͼ��ʾ x
plot(tx,x)
ylabel('���뼤��');
subplot(3,1,2);  % 2����ͼ��ʾ h
plot(th,h)
ylabel('��λ�弤��Ӧ');
subplot(3,1,3);  % 3����ͼ��ʾ y
plot(ty,y);
ylabel('�����Ӧ');
