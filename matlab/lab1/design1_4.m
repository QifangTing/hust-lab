a=[1,0.5];b=1; % ΢�ַ���ϵ��
t=[0:0.1:5]; tf=t(end);dt=tf/(length(t)-1);
u=cos(t); % ���뼤��
%����������弤��Ӧ
[r,p]=residue(b,a);
h=r(1)+exp(p(1)*t);
%�����弤��Ӧ
subplot(2,1,1);
plot(t,h);
grid;
%��u��h�ľ���������y(t)
y=conv(u,h)*dt;
%����y(t)
subplot(2,1,2);
plot(t,y(1:length(t)));
grid;