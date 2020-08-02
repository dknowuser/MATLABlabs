%Марчук Л.Б. 5307
%Лабораторная №1.1
%Функция проверки, на какой размерности входного вектора 
%ломается Wandermond
function result = WandTest()
    result = 1;
    
    %Признак выхода из цикла
    Exit = 0;
    
    %Ось n
    n = result;
    
    %Ось погрешностей
    Differs = 0;
    
    while ~Exit
        %Единичная матрица для сравнения
        Sample = eye(result);
        
        %Входной вектор
        x = zeros(1, result);
        for i=1:1:result
            x(i) = 10*rand();
        end;
        
        %Результат
        A = Wandermond(x);
        
        %Умножаем матрицу Вандермонда на обратную к ней
        Mul = A*inv(A);
        
        %Находим разницу
        Diff = Sample - Mul;
        Diff = abs(Diff);
        
        %Проверяем, превышает ли она 0,01
        %и заодно считаем максимальную погрешность
        MaxDiff = 0;
        for i=1:1:result
            for j=1:1:result
                if Diff(i, j) > 0.01
                    Exit = 1;
                    break;
                end;
                
                if Diff(i, j) > MaxDiff
                    MaxDiff = Diff(i, j);
                end;
            end;
            
            if Exit
                break;
            end;
        end;
        
        if Exit
            break;
        end;
        
        if result > 1  
            n = [n result];
            Differs = [Differs MaxDiff];
        else
            Differs = MaxDiff;
        end;
        
        result = result + 1;
    end;
    
    %Выводим зависимость от n
    hold on;
    plot(n, Differs);
end