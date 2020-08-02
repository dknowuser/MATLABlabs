%������ �.�. 5307
%������������ �1.1
%������� ��������, �� ����� ����������� �������� ������� 
%�������� Wandermond
function result = WandTest()
    result = 1;
    
    %������� ������ �� �����
    Exit = 0;
    
    %��� n
    n = result;
    
    %��� ������������
    Differs = 0;
    
    while ~Exit
        %��������� ������� ��� ���������
        Sample = eye(result);
        
        %������� ������
        x = zeros(1, result);
        for i=1:1:result
            x(i) = 10*rand();
        end;
        
        %���������
        A = Wandermond(x);
        
        %�������� ������� ����������� �� �������� � ���
        Mul = A*inv(A);
        
        %������� �������
        Diff = Sample - Mul;
        Diff = abs(Diff);
        
        %���������, ��������� �� ��� 0,01
        %� ������ ������� ������������ �����������
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
    
    %������� ����������� �� n
    hold on;
    plot(n, Differs);
end