% y(k)-0.81y(k-2)=x(k)-x(k-2)
% ��ʼ����Ϊyzi(0)=1,yzi(-1)=4
% ����Ϊ��λ��Ծ����

clear;
N=2;  % ��ַ��̽���
a=[1 0 -0.81];  % ��ַ��̷�ĸϵ������ a(0)~a(N)
b=[1 0 -1];  % ��ַ��̷���ϵ������ b(0)~b(N)
k=20;  % ���������Ŀ
zi=[1 4];  % ��ʼ״̬ N ��,��ʼ����Ϊyzi(0)=1,yzi(-1)=4
yzi=[0*ones(1,k+N+1)]; % ��ʼ����������Ӧ
h=yzi;% ��ʼ����λ������Ӧ
yzs=yzi;% ��ʼ����״̬��Ӧ
for n=1:N
   yzi(n)=zi(N-n+1);
end
y=yzi;% ��ʼ��ȫ��Ӧ������y(0)=yzi(0)=1,y(-1)=yzi(-1)=4
n=[-N:k];
x=[n==0];%��x=impseq(0,-N,k);������ͬ
%x=impseq(0,-N,k);
zic=filtic(b,a,zi); % ���������ʼ����yzi(0)=1,yzi(-1)=4ת��Ϊ����filter()����ĳ�ʼ����
h(N+1:end)=filter(b,a,x(N+1:end)); % �������� dimpulse ʵ��
x=[n>=0];%��x=stepseq(0,-N,k);������ͬ
%x=stepseq(0,-N,k);
yzs(N+1:end)=filter(b,a,x(N+1:end));
yzi(N+1:end)=filter([0 0],a,x(N+1:end),zic);
y(N+1:end)=filter(b,a,x(N+1:end),zic);
figure
subplot(3,1,1)
stem(n,x)
title('���� x(n)');
subplot(3,1,2)
stem(n,h)
title('�弤��Ӧ h(n)');
subplot(3,1,3)
hold on
stem(n,yzs,'g')
stem(n,yzi,'r')
stem(n,y)
hold off
legend('yzs','yzs','yzi','yzi','y','y')
title('�����Ӧ y(n)');
text={...
   ''
   '  ��λ�弤��Ӧ h='
   ''
   [' '*ones(1,12),num2str(h)]
   ''
   '  ��״̬��Ӧ yzs='
   ''
   [' '*ones(1,12),num2str(yzs)]
   ''
   '  ��������Ӧ yzi='
   ''
   [' '*ones(1,12),num2str(yzi)]
   ''
   '  ȫ��Ӧ y='
   ''
   [' '*ones(1,12),num2str(y)]
   ''};
textwin('��ַ�����ֵ��',text)
