close all;
clear;
clc;

N = 5;
A = rand(N);
B = rand(N);

tic
C1 = A*B;
toc

tic;
C2 = zeros(N);
for i = 1:N
    for j  = 1:N
        for k = 1:N
            C2(i,j) = C2(i,j) + A(i,k)*B(k,j);
        end
    end
end
toc;

err = norm(C1(:) - C2(:), 'inf')