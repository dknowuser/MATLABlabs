%Марчук Л.Б. 5307
%2e

%Данная программа находит производную заданной функции
%при помощи двойного дифференцирования интерполяционной
%формулы Ньютона.
%Она принимает на вход исследуемую функцию, x0 и h, d - делитель h.
%SecDerivE([1 0], 0, 100, 80)
function result = SecDerivE(func, x0, h, d)
    [rows, columns] = size(x0);
    if (rows~=1) || (columns~=1)
        error('Ошибка! x0 должно быть задано числом.');
    end;
        
    [rows, columns] = size(h);
    if (rows~=1) || (columns~=1)
        error('Ошибка! h должно быть задано числом.');
    end;
    
    [rows, columns] = size(d);
    if (rows~=1) || (columns~=1)
        error('Ошибка! d должно быть задано числом.');
    end;
    
    [rows, columns] = size(func);    
    if rows ~= 1
        error('Ошибка! Первый входной параметр должен быть вектором.');
    end;
    
    hs = [];
    Diff = [];
    alph = [];
    
    %Проходим по числу точек до d
    for n = 2:1:d    
        %Разбиваем интервал равноотстоящими точками
        %Определяем цену деления
        C = h / n;
        x = zeros(1, n);
        y = zeros(1, n);

        %Находим абсциссы и ординаты
        for i=1:1:n
            x(i) = x0 + C*(i - 1);
            y(i) = polyval(func, x(i));
        end;

        for i=1:1:n - 1
            y(i) = y(i + 1) - y(i);
        end;
        y(n) = [];
        n = n - 1;

        %Находим конечные разности (сохраняем с конечной разности второго порядка)
        Differences = [];
        factorialn = 2;
        hMul = C * C;

        while n > 1
            for i=1:1:n - 1
                y(i) = y(i + 1) - y(i);
            end;
            y(n) = [];
            n = n - 1;

            %Делим на факториал
            Value = y(1) / factorial(factorialn);

            %Делим на разность абсцисс между соседними точками
            Value = Value / hMul;

            hMul = hMul * C;
            factorialn = factorialn + 1;

            Differences = [Differences Value];
        end;

        [rows, columns] = size(Differences);

        %Находим полиномы при найденных конечных разностях и потом дважды
        %дифференцируем их
        pRes = 0;
        pBase = [1 -x(1)];

        for i=1:1:columns
            %Получаем полином при конечной разности очередного порядка
            pMul = [1 -x(i + 1)];
            pBase = conv(pBase, pMul);

            %Дважды его дифференцируем
            pDiff = MyDiff(MyDiff(pBase));

            %Домножаем на соответствующий коэффициент
            pDiff = pDiff * Differences(i);

            %Прибавляем к результирующему полиному
            if i > 1
                pRes = [0 pRes];
            end;
            pRes = pRes + pDiff;
        end;
        
        %Находим значение производной в данной точке
        result = polyval(pRes, x0);
        
        hs = [hs C];
        Diff = [Diff result];
        
        fcalc = result;
        freal = polyval(MyDiff(MyDiff(func)), x0);
        
        alpha = log(abs(fcalc - freal));
        alpha = alpha / log(C) + 20;
        alph = [alph alpha];
    end;
    
    %Выводим зависимость альфа от h
    hold on;
    plot(hs, alph, 'm');
    hold off;
    
    %Выводим реальную производную
    figure;
    hold on;
    px=x0:0.0001:(x0 + h);
    py = polyval(MyDiff(MyDiff(func)), px);
    plot(px, py, 'b');
    
    %Выводим найденную производную
    py = polyval(pRes, px);
    plot(px, py, 'r');
end