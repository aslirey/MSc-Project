clear all


load('DataTrain\DTrain_5773')

internet_a(internet_a==0) = NaN;

TrnData=fillmiss(internet_a);

N=200;

ftrain = v_enframe(TrnData, N+1, 1);%VoiceBox Toolbox enfame.m

X = ftrain(:,1:N);
Xresponse = ftrain(:,N+1);

clear internet_a

load('DataTest\DQID_5773')

internet_a(internet_a==0) = NaN;
TstData=fillmiss(internet_a);

ftest = v_enframe(TstData, N+1, 1);%VoiceBox Toolbox enfame.m

Y = ftest(:,1:N);
Yresponse = ftest(:,N+1);

%%%%%%% LR %%%%%%%%% 

LM=fitrlinear(X,Xresponse);
ypred = predict(LM,Y);%returns the predicted response values of  LM to the points in Z

[Yresponse, ypred];
errorL = Yresponse- ypred;

RMSELinear = sqrt(mean((errorL).^2)) %Root Mean Squared Error
MAELinear = mean(abs(errorL)) %Mean Absolute Error


 %%%%%%%%% SVM%%%%%%%%%

Mdl = fitrsvm(X,Xresponse);
YFit = predict(Mdl,Y);

[Yresponse, YFit];
errorSVM = Yresponse - YFit;



RMSESVM = sqrt(mean((errorSVM).^2)) %Root Mean Squared Error
MAESVM = mean(abs(errorSVM)) %Mean Absolute Error

%%%%%%%%Decision Tree%%%%%%%%%%%%%

tree = fitrtree(X,Xresponse);
Zfit = predict(tree,Y);

[Yresponse, Zfit];

errorDT =Yresponse - Zfit;

RMSEDT = sqrt(mean((errorDT).^2)) %Root Mean Squared Error
MAEDT = mean(abs(errorDT)) %Mean Absolute Error

%%%%%%%%Neural Network(feedforwardnet)%%%%%%%%%%%%%%%

TransposeX=X';
TransposeY=Xresponse';
TransposeZ=Y';
TransposeH=Yresponse';

net = feedforwardnet(50);
net = train(net,TransposeX,TransposeY);
view(net)
y = net(TransposeZ);
perf = perform(net,y,TransposeZ);

scatter(TransposeH,y)
% hold on

e   = TransposeH-y;


RMSENN = sqrt(mean((e).^2)) %Root Mean Squared Error
MAENN = mean(abs(e)) %Mean Absolute Error


