close all;
clear variables;
clc;
load cifar_10yunchao.mat;
X=cifar10;
X=X(:,1:end-1);

%Get the recall & precision
%'ITQ', 'RR', 'LSH' and 'SKLSH'
% [recall{1,1}, precision{1,1}] = test(X, 16, 'ITQ');
% [recall{1,2}, precision{1,2}] = test(X, 16, 'RR');
% [recall{1,3}, precision{1,3}] = test(X, 16, 'LSH');
% [recall{1,4}, precision{1,4}] = test(X, 16, 'SKLSH');

% [recall{1,1}, precision{1,1}] = test(X, 32, 'ITQ');
% [recall{1,2}, precision{1,2}] = test(X, 32, 'RR');
% [recall{1,3}, precision{1,3}] = test(X, 32, 'LSH');
% [recall{1,4}, precision{1,4}] = test(X, 32, 'SKLSH');

% [recall{1,1}, precision{1,1}] = test(X, 64, 'ITQ');
% [recall{1,2}, precision{1,2}] = test(X, 64, 'RR');
% [recall{1,3}, precision{1,3}] = test(X, 64, 'LSH');
% [recall{1,4}, precision{1,4}] = test(X, 64, 'SKLSH');

% [recall{1,1}, precision{1,1}] = test(X, 128, 'ITQ');
% [recall{1,2}, precision{1,2}] = test(X, 128, 'RR');
% [recall{1,3}, precision{1,3}] = test(X, 128, 'LSH');
% [recall{1,4}, precision{1,4}] = test(X, 128, 'SKLSH');

[recall{1,1}, precision{1,1}] = test(X, 16, 'ITQ');
[recall{1,2}, precision{1,2}] = test(X, 32, 'ITQ');
[recall{1,3}, precision{1,3}] = test(X, 64, 'ITQ');
[recall{1,4}, precision{1,4}] = test(X, 128, 'ITQ');


% Draw the plot
figure; hold on;grid on;
plot(recall{1, 1}, precision{1, 1},'g-^','linewidth',2);
plot(recall{1, 2}, precision{1, 2},'b-s','linewidth',2);
plot(recall{1, 3}, precision{1, 3},'k-p','linewidth',2);
plot(recall{1, 4}, precision{1, 4},'m-d','linewidth',2);
% plot(recall{1, 5}, precision{1, 5},'r-o','linewidth',2);
xlabel('Recall');
ylabel('Precision');
% legend('ITQ-16 bit','RR-16 bit','LSH-16 bit','SKLSH-16 bit','Location','NorthEast');
% legend('ITQ-32 bit','RR-32 bit','LSH-32 bit','SKLSH-32 bit','Location','NorthEast');
% legend('ITQ-64 bit','RR-64 bit','LSH-64 bit','SKLSH-64 bit','Location','NorthEast');
% legend('ITQ-128 bit','RR-128 bit','LSH-128 bit','SKLSH-128 bit','Location','NorthEast');
legend('ITQ-16 bit','ITQ-32 bit','ITQ-64 bit','ITQ-128 bit','Location','NorthEast');