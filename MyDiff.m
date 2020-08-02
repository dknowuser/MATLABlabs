function result = MyDiff(Input)
    result = Input;
    [rows columns] = size(result);
    
    %Берём производную
    if columns > 1
    for i=1:1:columns - 1
        result(i) = result(i) * (columns - i);
    end;    
    
    result(columns) = [];
    else
        result = 0;
    end;
end