%������� �������� ��� �������� ������������� �����
function result = LagRand(x, y)
    [rows, columns] = size(x);
    
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
end