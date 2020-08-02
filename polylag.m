%������ �.�. 5307
%������������ ������ �1.2
%������ ��������� ��������� �� ���� ������� ������������ ���������
%������ �������� �����, ���������� ����� �������� ���������,
%� �� ���� ������ ������ ���������������� ��������� ��������.
function result = polylag(a, b, y)
    
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
    
    %���������������� ��������� ��������
    result = zeros;
    
    %����� �����
    for i=1:1:columns
        Temp = y(i);
        
        %������� �����������
        Mul = 1;
        for j=1:1:columns
            if i == j
                continue;
            end;
                
            Mul = Mul * (x(i) - x(j));
        end; 
        Temp = Temp / Mul;
        
        %������� ���������
        Mul = 1;
        for j=1:1:columns
            if i == j
                continue;
            end;
            
            Mul = conv(Mul, [1 -x(j)]);
        end;
        
        Temp = Temp * Mul;
        result = result + Temp;
    end;
    
    %������� ���������
    hold on;   
    plot(x,y);
    
    plx=x(1):0.01:x(columns);
    ply = polyval(result, plx);
    plot(plx, ply);
end