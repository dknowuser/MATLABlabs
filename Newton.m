%������ �.�. 5307
%������������ ������ �1.2
%������ ��������� ��������� �� ���� ������� ������������ ���������
%������ �������� �����, ���������� ����� �������� ���������,
%� �� ���� ������ ������ ���������������� ��������� �������.

function result = Newton(a, b, y)
[rows, columns] = size(a);

    if (rows~=1) || (columns~=1)
        error('������! ������� ������������ ��������� ������ ���� ������ �������.');
    end;
    
    [rows, columns] = size(b);
    
    if (rows~=1) || (columns~=1)
        error('������! ������� ������������ ��������� ������ ���� ������ �������.');
    end;

    [rows, columns] = size(y);
    
    if rows ~= 1
        error('������! ��������� ������� �������� ������ ���� ��������.');
    end;
    
    if b < a
        error('������! �������� ������ ������� ��������� ������ ���� ������');
    end;
    
    %����� ������� ����������� �������
    %���������� ���� �������
    C = (b - a) / (columns - 1);
    x = zeros(rows, columns);
    Column = 1;
    
    %������� ��������
    for i=a:C:b
        x(Column) = i;
        Column = Column + 1;
    end;
    
    %���������������� ��������� �������
    result = y(1);
    
    Tempy = y;
    Tempc = columns;
    
    for i=1:1:columns - 1
        %������� �� ������ ���� �������� ��������
        for j=1:1:columns - 1
            y(j) = y(j + 1) - y(j);
        end;
        y(columns) = [];
        
        Mul = 1;
        for j=1:1:i
            Mul = MyConv(Mul, [1 -x(j)]);
        end;
        
        Mul = Mul * y(1);
        Mul = Mul / ((x(2) - x(1))^i);
        Mul = Mul / factorial(j);
        
        result = [0 result];
        result = Mul + result;
        columns = columns - 1;
    end;
    
    %������� ���������
    hold on;
    
    plot(x,Tempy);
    
    plx=x(1):0.01:x(Tempc);
    ply = polyval(result, plx);
    plot(plx, ply);
    
    hold off;
end