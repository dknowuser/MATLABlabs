%Марчук Л.Б. 5307

%Данная программа в качестве входных параметров
%принимает произвольный набор (n + 2)-х точек
%a <= t0 < t1 < ... < tn+1 <= b и точность
%и находит многочлен наилучшего приближения 
%по алгоритму Ремеза.
%MyRemez([-8 -5 0 2 3], 0.1)
function result = MyRemez(points, Epsilon)
    %Задаём исследуемую функцию
    f = @(x)sin(x);
    
    d = 0;
    D = 1;
    [rows, columns] = size(points);
    P = [];
    
    %Основной цикл пока |d| ~= D
    while abs(D - d) >= Epsilon
        %Очищаем экран
        clf;
        
        %Выводим исследуемую функцию
        hold on;
        px=points(1):0.001:points(columns);
        plot(px, f(px), 'b');

        %Выводим найденные точки
        plot(points, f(points), 'm*');
        
        %Ищем аппроксимирующий многочлен
        %Составляем матрицу коэффициентов при aj (матрица Вандермонда)
        A = Wandermond(points);
        [rows acol] = size(A);
        for i=1:1:acol/2
            Temp = A(:,i);
            A(:,i) = A(:,acol - i + 1);
            A(:,acol - i + 1) = Temp;
        end;
        
        %Составляем вектор-столбец правой части
        B = f(points)';
        
        A = [A B];
        for i=1:1:columns
            A(i, acol + 1) = (-1).^i;
        end;
        
        %Решаем систему линейных уравнений
        P = A\B;
        
        %Строим аппроксимирующий многочлен
        P = P';
        d = abs(P(columns + 1));
        P(columns + 1) = [];
        
        %Выводим найденный многочлен
        plot(px, polyval(P, px));
        
        %Ищем xmax такое, что D = |f(ksi) - P(ksi)| = max
        delta = @(x) -abs(f(x) - polyval(P, x));
        xmax = points(1);
        D = -delta(points(1));
        
        for i=points(1):((points(columns) - points(1))/1000):points(columns)
            [dx, dy] = fminbnd(delta, i, i + ((points(columns) - points(1))/10000));
            
            dy = -dy;
            if dy > D
                D = dy;
                xmax = dx;
            end;
        end;
        
        %Замена
        if (xmax > points(1)) && (xmax < points(columns))
            i = 1;
            while xmax > points(i)
                i = i + 1;
            end;
            
            if delta(xmax)*delta(points(i)) >= 0
                points(i) = xmax;
            else
                points(i - 1) = xmax;
            end;
        else
            if xmax < points(1)
                Temp = points(1);
                points(1) = xmax;
                if delta(xmax)*delta(Temp) < 0
                    for j=1:1:columns - 1
                        points(j + 1) = points(j);
                    end;
                end;
            else
                Temp = points(columns);
                points(columns) = xmax;
                if delta(xmax)*delta(Temp) < 0
                    for j=1:1:columns - 1
                        points(j) = points(j + 1);
                    end;
                end;
            end;
        end;        
        %Пауза для просмотра
        pause(1);
    end;
end