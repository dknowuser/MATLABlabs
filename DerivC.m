%Марчук Л.Б. 5307
%2c

%Данная программа находит производную заданной функции
%по формуле f'(x0) = (-(x2) + 8f(x1) - 8f(x-1) + f(x-2))/(12*h)
%f'(x0) = (f(x0 - 2h) - 8f(x0 - h) + 8f(x0 + h) - f(x0 + 2h)) / (12*h);
%в заданной точке x0 (на вход - функция, x0 и h, d - делитель h).
%DerivC([1 0 0], 10, 1, 400)
%DerivC([1 0 0 0], -10, 0.01, 400)
function result = DerivC(func, x0, h, d)
    [rows, columns] = size(x0);
    if (rows~=1) || (columns~=1)
        error('Ошибкfа! x0 должно быть задано числом.');
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
    
    hold on
    hs = [];
    Step = h/d;
    alph = [];
    %В цикле проходим от большего h к меньшему h
    for i=d:-1:1
        hs = [hs Step*i];
        result = (polyval(func, x0 - 2*Step*i) - 8*polyval(func, x0 - Step*i) + 8*polyval(func, x0 + Step*i) - polyval(func, x0 + 2*Step*i))/(12*Step*i);       

        fcalc = result;
        freal = polyval(MyDiff(func), x0);

        alpha = log(abs(fcalc - freal)) + 29;
        alpha = alpha / log(Step*i) + 2;
        alph = [alph alpha];
    end;
    plot(hs, alph, 'm');
    hold off;
    
    %Выводим реальную производную
    figure;
    hold on;
    px=(x0 - 100):0.01:(x0 + 100);
    py = polyval(MyDiff(func), px);
    plot(px, py, 'b');
    
    %Выводим найденную производную 
    py = (polyval(func, px - 2*Step) - 8*polyval(func, px - Step) + 8*polyval(func, px + Step) - polyval(func, px + 2*Step))/(12*Step);       
    plot(px, py, 'r');
end