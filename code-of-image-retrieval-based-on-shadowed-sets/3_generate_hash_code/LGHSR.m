function [B] = LGHSR(V,r)
    traindata = V(1:50000,1:end);
    testdata = V(50001:end,1:end);

    load('anchor_cifar10_600.mat');
    anchor = double(center);

    tic;
    [Y, W, F, Z, sigma] = raw_sh(traindata, anchor, r, s,0);
    tY = OneLayerAGH_Test(testdata, anchor, W, s, sigma);
    clear W;
    toc;
    Y = [Y;tY];
    clear tY; 
end
       
