%������ �.�. 5307
%������������ �1.1
%�������� ��� n = 15

function result=Wandermond(x) 
    [m, n] = size(x);
    
    if m ~= 1
        error('������! ������� �������� ������ ���� ��������.');
    end;
    
    %������ ������� �����������
    result = ones(n, 1);
    
    for i=1:1:(n - 1)
        Temp = x';
        Temp = Temp.^i;
        result = [result, Temp];
    end;
end