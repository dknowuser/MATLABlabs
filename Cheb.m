%Марчук Л.Б. 5307
%Лабораторная №1.4
%Данная программа принимает на вход границы исследуемого отрезка,
%число корней многочлена Чебышёва(исследуемая функция задаётся в коде)       
%и  ищет на этом отрезке корни Чебышева, строит по найденным корням 
%полином Лагранжа и в случайно выбранной точке на исследуемом отрезке 
%сравнивает погрешность с теоретически рассчитанной погрешностью.
function result = Cheb(a, b, steps)
        [rows, columns] = size(a);
        if (rows~=1) || (columns~=1)
            error('Ошибка! Границы исследуемого отрезка должны быть заданы числами.');
        end;
        
        [rows, columns] = size(b);
        if (rows~=1) || (columns~=1)
            error('Ошибка! Границы исследуемого отрезка должны быть заданы числами.');
        end;
        
        [rows, columns] = size(steps);
        if (rows~=1) || (columns~=1)
            error('Ошибка! Последний параметр должен быть числом.');
        end;
        
        if a > b
            error('Начальная точка отрезка должна быть меньше конечной.');
        end;
        
        %Задаём функцию
        poly = [5 -4 3 -2 1];
        
        %Выводим её на экран
        hold on;
        plx=a:0.01:b;
        ply = polyval(poly, plx);
        plot(plx, ply, 'b');
        
        %Предыдущий многочлен Чебышёва
        Tprev = [0 1];
        
        %Текущий многочлен Чебышёва
        Tcur = [1 0];
        
        %Ищем многочлен Чебышёва на требуемом шаге
        for i=1:1:steps - 1
            Temp = Tcur;
            Tcur = 2 * [1 0];
            Tcur = conv(Tcur, Temp);

            %Увеличиваем размер вектора Tprev
            [rows, columns] = size(Tcur);
            Diff = columns;
            [rows, columns] = size(Tprev);
            Diff = Diff - columns;
            for j=1:1:Diff
            	Tprev = [0 Tprev];
            end;

            Tcur = Tcur - Tprev;
            Tprev = Temp;
        end;
        
        %Ищем корни найденного многочлена на заданном отрезке
        R = roots(Tcur);
        if steps > 1
            R = R';

            %Проецируем корни на заданный интервал
            %Размах абсцисс корней Чебышёва
            CR = max(R) - min(R);

            %Длина исследуемого отрезка
            CInt = b - a;

            %Коэффициент масштабирования
            Mul = CInt/CR;

            R = R - min(R);

            R = a + R*Mul;
        end;
        
        %Вычисляем значения искомой функции в точках корней Чебышева 
        hold on;
        V = polyval(poly, R);
        plot(R, V, 'ko');
        
        %Строим по ним полином Лагранжа
        La = LagRand(R, V);
        
        %Округляем его
        La = (round(La * 1000000))/1000000;
        
        %Выводим полином Лагранжа
        plx=a:0.01:b;
        ply = polyval(La, plx);
        plot(plx, ply, 'r');
        
        %Выбираем точку, лежащую между корнями Чебышева
        R = sort(R);
        Sample = abs(R(2) - R(1))*rand() + min(R(2), R(1));
        %Sample = 0.6;
        
        %Находим погрешность
        oy = polyval(poly, Sample);
        ly = polyval(La, Sample);
        mDiff = abs(oy - ly);
        
        %Находим теоретическую погрешность      
        for i=1:1:steps + 1
            %Ищем производную            
             poly = MyDiff(poly);            
        end;
        
        plx=a:0.01:b;
        ply = polyval(poly, plx);
        tMax = max(ply);
        tDiff = tMax*(b - a)^(steps + 1)/(2^(2*steps + 1)*factorial(steps + 1));
        
        if mDiff <= tDiff
            disp('Вычисленное значение погрешности в точке ');
            disp(Sample);
            disp(' меньше или равно теоретическому.');
        else
            disp('Вычисленное значение погрешности в точке ');
            disp(Sample);
            disp(' больше теоретического.');
        end;
        
        disp('Теоретическая погрешность:');
        disp(tDiff);
        disp('Практическая погрешность:');
        disp(mDiff);
end