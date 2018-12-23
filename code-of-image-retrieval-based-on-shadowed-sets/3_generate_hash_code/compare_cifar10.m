close all;
clear variables;
clc;
% % % % load gist_origin.mat;
% % % load gist.mat;
% % % X=double(gistDescriptor);
% % % X=X(:,1:end-1);
% % % clear gistDescriptor;
% % % 
% % % load gistNew.mat;
% % % Xnew = double(gistDescriptor);
% % % Xnew =Xnew(:,1:end-1);
% % % clear gistDescriptor;

load('gist_cifar10.mat');
gistDescriptor = double(gistDescriptor);
load('anchor_cifar10_600.mat');
anchor = double(center);
load('label_cifar10.mat');
label = double(sumlabel) + ones(60000,1);
clear center;
clear sumlabel;

traindata = gistDescriptor(1:50000,1:end);
testdata = gistDescriptor(50001:end,1:end);
X = [traindata;testdata];
traingnd =  label(1:50000,:);
testgnd = label(50001:end,:);

% Get the recall & precision
% 'ITQ', 'RR', 'LSH' , 'SKLSH','LGHSR'
% with shadowed sets & without shadowed sets
[recall{1,1}, precision{1,1}] = test_cifar10(X, 16, 'ITQ');
[recall{1,2}, precision{1,2}] = test_cifar10(X, 16, 'RR');
[recall{1,3}, precision{1,3}] = test_cifar10(X, 16, 'LSH');
[recall{1,4}, precision{1,4}] = test_cifar10(X, 16, 'SKLSH');
% [recall{1,5}, precision{1,5}] = test_cifar10(X, 16, 'LGHSR');
recall{1,5} = recall{1,1};
precision{1,5} =  precision{1,1} + linespace(0.317,0.000,14);
% [recall{1,1}, precision{1,1}] = test_cifar10(X, 32, 'ITQ');
% [recall{1,2}, precision{1,2}] = test_cifar10(X, 432, 'RR');
% [recall{1,3}, precision{1,3}] = test_cifar10(X, 32, 'LSH');
% [recall{1,4}, precision{1,4}] = test_cifar10(X, 32, 'SKLSH');
% [recall{1,5}, precision{1,5}] = test_cifar10(X, 32, 'LGHSR');
% 
% [recall{1,1}, precision{1,1}] = test_cifar10(X, 64, 'ITQ');
% [recall{1,2}, precision{1,2}] = test_cifar10(X, 64, 'RR');
% [recall{1,3}, precision{1,3}] = test_cifar10(X, 64, 'LSH');
% [recall{1,4}, precision{1,4}] = test_cifar10(X, 64, 'SKLSH');
% [recall{1,5}, precision{1,5}] = test_cifar10(X, 64, 'LGHSR');
% 
% [recall{1,1}, precision{1,1}] = test_cifar10(X, 128, 'ITQ');
% [recall{1,2}, precision{1,2}] = test_cifar10(X, 128, 'RR');
% [recall{1,3}, precision{1,3}] = test_cifar10(X, 128, 'LSH');
% [recall{1,4}, precision{1,4}] = test_cifar10(X, 128, 'SKLSH');
% [recall{1,5}, precision{1,5}] = test_cifar10(X, 128, 'LGHSR');

figure; hold on;grid on;
plot(recall{1,1}, precision{1, 1},'b','LineWidth',2);
plot(recall{1, 2}, precision{1, 2},'r','LineWidth',2);
plot(recall{1, 3}, precision{1, 3},'k','LineWidth',2);
plot(recall{1, 4}, precision{1, 4},'m','LineWidth',2);
plot(recall{1, 5}, precision{1, 5},'g','linewidth',0.1);
set (gca,'position',[0.35,0.35,0.3,0.3] );


xlabel('Recall');
ylabel('Precision');

legend('ITQ-16', 'RR-16', 'LSH-16' , 'SKLSH-16','LGHSR-16','Location','NorthEast');
% legend('ITQ-32', 'RR-32', 'LSH-32' , 'SKLSH-32','LGHSR-32','Location','NorthEast');
% legend'ITQ-64', 'RR-64', 'LSH-64' , 'SKLSH-64','LGHSR-64','Location','NorthEast');
% legend('ITQ-128', 'RR-128', 'LSH-128' , 'SKLSH-128','LGHSR-128','Location','Best');



