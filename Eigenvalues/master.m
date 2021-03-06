%% Microchip Voltage
%1. Read CSV file
A = csvread("voltage_evolve.csv")
% Initial condition
%%V = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
V0 = [1;zeros(20,1)];
M120 = zeros(21,120);
%2. Calculate Voltages for 120ms
n = 120
V = V0
for i = 1:n
    M120(:,i)= A * V;
    V = M120(:,i);
end

M120=[V0,M120]
V = M120

%Voltages in first 5 locations
output = V(1:5,:) % require for each vector 0 to 120
%write to csv file for checking with excel
%%csvwrite('output.csv', output)

%3. GOAL 1: PLOT RESULT
figure(1);
plot(1:n+1,output,'-')

%4. GOAL 2: text file of V120 : voltages at 21 locations at the 120th millisecond
file = fopen('M120.txt','w')
MOut = M120(:,121)
fprintf(file,'%6.4f\n',MOut);
fclose(file);

%5. calculate eigenvalues and eigenvectors of Ausing eigs
eigen = eig(A)
%6. calculate largest eignevalue (sort or max command)    
eigen = abs(eigen)
max(eigen)

%7. GOAL 3: COMPARE LARGEST WITH TIME EVOLUTION
[V,D] = eig(A)
temp = [V,D]
largeEig = temp(:,1:1)

file = fopen('largeEig.txt','w')
fprintf(file,'%6.4f\n',largeEig);
fclose(file);

figure(3);
hold on;
plot(largeEig,'o')
plot(abs(largeEig),'b--o')
plot(MOut)

legend('V120','Largest Eig','Abs(LargestEig)')
hold off;
% The largest eigenvalue follows the same path however is the inverse.
% Looking more closely, the absolute value was calculated and plotted, it can be seen that
% the absolute values of V120 and the Largest Eigenvalue are different by roughly 0.05. 

%8. ~Vn = A^-1*~Vn+1
Ai = inv(A)
% Calculate Voltages for 120ms
n = 120
V = V0

M_I120 = V0;
%9. Backtrack ~V120 to ~V98
for i=120:-1:1
    V = Ai * M120(:,i);
    disp(V)
    M_I120 = [V,M_I120];
end
Vi = M_I120
%Move V0 from end to start
Vi = [V0, M_I120]
Vi = Vi(:,1:end-1)
%10. GOAL 4: On a new figure, plot the values of ?? as circles,
% on top of the values of ?? as lines.
output2 = Vi(1:5,1:22)
figure(2);
% Generate plot with circles
plot(1:22,output2, 'o')
% Display both plots on same figure
hold on
plot(1:n+1,output)
hold off;

%11. GOAL 5: Comment on the similarities and differences between the normal calculation forwards in time for the voltages and the backtracked values
%In comparison to the forward values, the backwards in time values were similiar in value, however varied by 0.2 from 10ms to 120ms. Below 10ms, the values varied significantly and at 1ms, the backwards tracked was very inaccurate.
%This shows that a backwards calculation is not as accurate as forwards. The results of each calculation followed a similar path.
%13. GOAL 6: FIND CONDITION NUMBER cond(A)
cond(A)
cond(Ai)

%14. GOAL 7: Calculate the largest eigenvalue for A and the largest eigenvalue for A^-1. Comment on the difference.
disp('Largest eigenvalue of A')
eigA = eigs(A);
eigA = abs(eigA);
eigA = max(eigA)

disp('Largest eigenvalue of Ai')
eigAi = eigs(Ai);
eigAi = abs(eigAi);
eigAi = max(eigAi)

%%disp('Comment on the differences')
% The largest eigenvalue for A is very close to 1. When finding the inverse of A, all the
% eigenvalues were complex numbers. Given that a complex number cannot be
% larger than a real number, the absolute value was found in both cases.
% This resulted in A= 1.0012 and Ai = 5.0111, this can also be seen in the
% generated graph, however on the graph Ai is a negative value. These
% results show a high discrepency between backwards and forwards
% calculations.

%15. GOAL 8: Write out the values of Vn and ~Vn to a file called
%'Voltages.csv'

writematrix(M120,'Voltages.csv')
dlmwrite('Voltages.csv','','delimiter',',','-append');
dlmwrite('Voltages.csv',Vi,'delimiter',',','-append');

