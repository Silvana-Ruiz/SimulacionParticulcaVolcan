%Silvana Dorita Ruiz Olivarría A01252346
%María Carelia Ibarra Vásquez A01251463 
%José Daniel Pablos Valenzuela A01252290
%Javier Humberto González Garza A01253836
clear all;
clc;

figure(1);

img = imread('pyroclastic_flow_77.jpg');
image('CData',img,'XData',[-30 30],'YData',[30 0])

axis([-20, 20, 0, 30]);

volcanx=[-10,10,6,4,1,-1,-4,-6];
volcany=[0,0,5,10,15,15,10,5];
volcancolor=[.62,0.51,0.44];
p1 = patch(volcanx,volcany, volcancolor);


hold on
angulos = [86 89 80 130 115 120];
velocidades = [9.1 10 9.1 10.9 10.2 9.1];


g = 9.81;  

dx = 0.1;
x = 0:dx:10;

figure(1);
hold on
axis([-20 20 0 30]);

for j = 1:3
    dx = 0.1;
    x = 0:dx:100;
    a = angulos(j)*(pi/180);
    v0 = velocidades (j);
    y = zeros(1, length(x));
    size = 12;
    for i=1:length(x)
        if (y >= 0)
             y(i) = 15+(tan(a)*(x(i))-(g/(2*v0^2*cos(a)^2))*(x(i)^2));
             color1 = [0.88 (7*i)/length(x) 0.50];
             size = size - size*i*0.25/length(x);
             p2 = plot(x(i),y(i),'ko','Markersize', size,'MarkerFaceColor', color1);
             pause(0.000001);
        end
    end
end

for j = 4:6
    dx = -0.1;
    x = 0:dx:-100;
    a = (angulos(j))*(pi/180);
    v0 = velocidades (j);
    y = zeros(1, length(x));
    size = 12;
    for i=1:length(x)
         if (y >= 0)
             y(i) = 15+(-tan(a)*(-x(i))+(g/(2*v0^2*cos(a)^2))*(-x(i)^2));
             color2 = [0.88 (5.08*i)/length(x) 0.50];
             size = size - size*i*0.25/length(x);
             p2 = plot(x(i),y(i),'ko','Markersize', size,'MarkerFaceColor',color2);
             pause(0.000001);
         end
    end
end

figure(1);

hold on

dx = 0.1;
x = 0:dx:20;
angulos = [86 89 80 130 115 120];
velocidades = [9.1 10 9.1 10.9 10.2 9.1];

g=9.81;     
x0 = 0;
y0 = 15;

figure(1);
hold on
axis([-20 20 0 30]);


for j = 1:length(angulos)
    a = angulos(j);
    v = velocidades(j);
    Euler = zeros(1,length(x));
    Euler(1) = y0;
    for i = 2:length(x)
        size = 12;
        
        if (a > 90)
            if (Euler(i) < 0)
                break
            else
                m = tan(a)-2*(g/(2*v^2*cos(-a)^2))*x(i);
                Euler(i) = Euler(i-1) + dx*m;
                color2 = [0.20 i/length(x) 0.80];
                size = size - size*i*0.5/length(x);
                p3 = plot(-x(i),Euler(i),'ko','Markersize', size,'MarkerFaceColor',color2);
                pause(0.00001)
            end
        else
            if (Euler(i) < 0)
                break
            else
                m = tan(a)-2*(g/(2*v^2*cos(a)^2))*x(i);
                Euler(i) = Euler(i-1) + dx*m;
                color2 = [0.20 i/length(x) 0.80];
                size = size - size*i*0.5/length(x);
                p3 = plot(x(i),Euler(i),'ko','Markersize', size,'MarkerFaceColor',color2);
                pause(0.00001)
            end
        end
    end
end
h = [p1; p2(1); p3(1)];
xlabel('x'), ylabel('y'), title ('Volcán'), legend(h, 'Volcán', 'Exacta', 'Euler');

hold off