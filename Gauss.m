%Марчук Л.Б. 5307
%Данная программа вычисляет интеграл заданной функции
%с помощью трёхточечной формулы Гаусса.
%В качестве входных параметров программа принимает
%начальную и конечную точку отрезка интегрирования,
%начальное число точек разбиения и конечное число точек разбиения
%и точность, с которой обрезаются бесконечные концы.
%h1 < h2
%[integr time] = Gauss(1, inf, 100, 1000, 0.0001);
function [result, meastime] = Gauss(a, b, h1, h2, Eps)
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
        
        %Вычисляем интеграл
        result = 0;
        for j=a:c:(b - c)
            x1 = j + c/2*(1 - sqrt(3/5));
            x2 = j + c/2;
            x3 = j + c/2*(1 + sqrt(3/5));
            result = result + c/18*(5*f(x1) + 8*f(x2) + 5*f(x3));
        end;
        
        %Вычисляем альфа        
        alpha = -(log(abs(result - freal)));
        alpha = alpha / log(i);% + 3;
        alph = [alph alpha];
    end;
    meastime = cputime() - StartTime;
    
    hold on;
    plot(hs, alph, 'm');
    hold off;
end