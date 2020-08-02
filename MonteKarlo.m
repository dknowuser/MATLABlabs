%������ �.�. 5307
%������ ��������� ��������� �������� �������� �������
%������� �����-�����. � �������� ������� ���������� ��������� ���������
%������� ��������������, ���������� ��������� �������
%� ��������, � ������� ���������� ����������� �����.
%[integr time] = MonteKarlo(1,inf,25600000,0.0001);
%N = 25600000
function [result, meastime] = MonteKarlo(a, b, N, Eps)
    %����� �������
    f = @(x)1/(x*x + 1);
    
    %�������� ����������� ������� ���������
    if a == inf
        a = 0;
        while abs(f(a)) >= Eps
            a = a - 0.0001;
        end;
    end;
    
    if b == inf
        b = 0;
        while abs(f(b)) >= Eps
            b = b + 0.0001;
        end;
    end;
        
    result = 0;
    
    %�������� ������ ������������ �������
    StartTime = cputime();
    
    %�������� N ����� �� ������� ��������������
    for i=1:1:N
        temp = rand()*(b - a) + a;
        
        %��������� �������� ������� � ���� ������
        result = result + f(temp);
    end;
    result = result*(b - a)/N;
    meastime = cputime() - StartTime;
end