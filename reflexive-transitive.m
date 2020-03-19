
%1. Create an isreflexive function that tests for reflexivity in the same 
%way that the issymmetric function tests for symmetry. 
%Recall that this function must check if all the diagonal elements are true. (3 marks)
load R.mat
issymmetric(R1) % true
isreflexive(R1) % true
istransitive(R1) % also true, therefore R1 is an equivalence relation
plot(digraph(R1)) % shows a graph made up of 5 disjoint graphs, therefore R1 is an equivalence relation with 5 equivalence classes

%Define Function
function status =isreflexive(A)
    [rows, ~] = size(A);
    total = 0; %Count through matrix setting diagonals to zero
    for i = 1:rows  
        if A(i,i) == 1
            total = total + 1;  % increment counter for each row where conditions met
            %disp(total)
            %disp(A(i,i))
        else
            
        end
        if total == rows        %if xRx for all x exists in A
            status = 1;     % 1 = true
        else
            status = 0;
        end
    end
end

% 2. Create an istransitive function that tests for transitivity. 
%Recall that this function returns true if all non-zero elements in 
%??2 are accompanied by non-zero (true) elements at the same locations in ??. (5 marks)
function transitive = istransitive(R)
    [rows, ~] = size(R);
    Rsquared = R*R;
    transitive = true;      % assumes true. Sets to false if not
    for i = 1:rows
        if transitive == false
            break	% exit for loop (i)
        end
        for j = 1:rows
            if Rsquared(i,j) > 0           % if transitive conditions arent met, set to false
                if R(i,j) ==  0
                    transitive = false;
                    break	% exit for loop (j)
                end
            end
        end
    end
end