%  design1_1.m
T=0.01;  % ȡ������
tx=2:T:4;
x=rectpuls((tx-3),2);  % ���� rectpuls �������ο� help rectpuls
th=3:T:5;
h=rectpuls((th-4),2);
t=(2+3):T:(4+5);  % �����ź������������ֽ�β���
y=conv(x,h);  % ������
figure
subplot(3,1,1);  % ����ͼ��ʾ����ͼ�ο��Ϊ 3x1 ����ͼ��1����ͼ��ʾ x
plot(tx,x)
ylabel('���뼤��');
subplot(3,1,2);  % 2����ͼ��ʾ h
plot(th,h)
ylabel('��λ�弤��Ӧ');
subplot(3,1,3);  % 3����ͼ��ʾ y
plot(t,y) 
ylabel('�����Ӧ');
