%% ʹ��SVM��Ϊ����������һ��ѡȡѵ�����Լ�
clear all;close all;clc;
%  ׼�����ݣ����淶���ݸ�ʽ��libsvm��label��m����������m*1,��������
%  feature,m��������nά������m*n
clear all;close all;clc;
load 'CASME2_feature_STLBP_IP_YT.mat';
load 'CASME2_label.mat';
feature_yt = feature_yt';
N = length(label);  %NΪlabel����
rate = 0;
for i = 1:N
    [train,test] = crossvalind('LeaveMOut',N,1);%��һ��
    %ѵ����
    train_feature = feature_yt(train,:)
    train_label = label(train);
    %���Լ�
    test_feature = feature_yt(test,:)
    test_label = label(test);
    %svmģ��
    model = svmtrain(train_label,train_feature);
    %��֤���
    [predicted_label, accuracy, prob_estimates] = svmpredict(test_label, test_feature, model, 'b');
    rate = rate + accuracy(1);
end

%%����ʶ����
rate = rate/(N*100)