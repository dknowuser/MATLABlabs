%Марчук Л.Б. 5307
%Данная программа вычисляет интеграл заданной функции
%методом Симпсона и вычисляет скорость сходимости интеграла.
%В качестве входных параметров программа принимает отрезок интегрирования,
%начальное число точек разбиения и конечное число точек разбиения
%и точность, с которой обрезаются бесконечные концы.
%h1 < h2
%h/3(f(x0) + 4sum(1,n)f(x2i-1) + 2sum(1,n-1)f(x2i) + f(x2n))
%[integr time] = Simpson(1, inf, 100, 1000, 0.0001);
function [result, meastime] = Simpson(a, b, h1, h2, Eps)
    %Задаём функцию
    f = @(x)1/(x*x + 1);
    freal = pi/4;
    
    %Обрезаем бесконечные границы интервала
    if a == inf
        a = 0;
        while abs(f(a)) >= Eps
            a = a - 0.0001;
        end;
    end;
    
    if b == inf
        b = 0;
        while abs(f(b)) >= Eps
            b = b + 0.0001;
        end;
    end;
    
    hs = [];
    alph = [];
    
    %Начинаем отсчёт затраченного времени
    StartTime = cputime();
    
    for i=h1:1:h2        
        %Находим длину отрезка деления
        c = (b - a) / i;        
        hs = [hs c];
        
        result = f(a) + f(b);
        
        for j = a + c:2*c:b
            result = result + 4*f(j);
        end;
        
        for j = a + 2*c:2*c:b - c
            result = result + 2*f(j);
        end;
        
        %Домножаем на h/3
        result = result*c/3;
        
        %Вычисляем альфа        
        alpha = -(log(abs(result - freal)));
        alpha = alpha / log(i);% + 3.525;
        alph = [alph alpha];
    end;
    meastime = cputime() - StartTime;
    
    hold on;
    plot(hs, alph, 'm');
    hold off;
end