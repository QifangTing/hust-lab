% design5_1.m
% x = 1 2 3 6 2 , 4:8
% h = 1 0 2, 1:3

x=[0 0 0 1 2 3 6 2];
h=[1 0 2];
y=conv(x,h);
figure
subplot(3,1,1)
stem(x)
ylabel('����x(n)');
subplot(3,1,2)
stem(h)
ylabel('�弤��Ӧh(n)');
subplot(3,1,3)
stem(y)
ylabel('�����Ӧy(n)');
text={...
   ' '
   '  �������� x='
   ' '
   [' '*ones(1,12),num2str(x,'%8g')]
   ' '
   '  ��λ�弤��Ӧ���� h='
   ' '
   [' '*ones(1,12),num2str(h,'%8g')]
   ' '
   '  ��Ӧ���� y='
   ' '
   [' '*ones(1,12),num2str(y,'%8g')]
   ' '};
% textwin('�������������ֵ��ʾ',text)