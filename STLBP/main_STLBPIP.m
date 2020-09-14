%% �����������Ҫ��������ȡ΢��������������Facial Micro-Expression 
%  Recognition using Spatiotemporal Local Binary Pattern with Integral 
%  Projection�������STLBP-IP������

%% read images and extracted features
clear all;close all;clc;
cd ('E:\STLBP\Datas\List_');
a = dir('E:\STLBP\Datas\List_'); %Layer 1
feature_xy = [];
feature_yt = [];
feature_xt = [];
for i = 1 : length(a)
    if (strcmp(a(i).name, '.') == 1)|| (strcmp(a(i).name, '..') == 1)
        continue;
    end
    b = dir (fullfile(a(i).folder,'\',a(i).name)); %Layer 2
    
    for j = 1 : length(b)
        if (strcmp(b(j).name, '.') == 1)|| (strcmp(b(j).name, '..') == 1)
            continue;    
        end
        cd (fullfile(b(j).folder,'\',b(j).name));
        c = dir('*.jpg');
        
        for k = 1 : length(c)
            Imgdat = imread(getfield(c, {k}, 'name'));
            if size(Imgdat, 3) == 3 % if color images, convert it to gray
                Imgdat = rgb2gray(Imgdat); 
            end
            [height, width] = size(Imgdat);
            if k ==1
                VolData = zeros(height, width, length(c));
            end
            VolData(:, :, k) = Imgdat;        
        end
        %% xyƽ�������fxy,���ú���STLBP_IP_XY
        cd ('E:\STLBP\STLBP_IP');
        W = 9;
        fxy = STLBP_IP_XY(VolData,W);  %fxy����������256*2λ����
        feature_xy = [feature_xy,fxy];
        %% ˮƽͶӰ������fyt�����ú���STLBP_IP_YT
        fyt = STLBP_IP_YT(VolData)  %fyt����������59ά����
        feature_yt = [feature_yt,fyt];
        %% ��ֱͶӰ������fxt�����ú���STLBP_IP_XT
        fxt = STLBP_IP_XT(VolData)  %fxt����������59ά����
        feature_xt = [feature_xt,fxt];
    end
      
end
cd ('F:\matlab\2015_STLBP_IP');
save('CASME2_feature_STLBP_IP_XY','feature_xy');
save('CASME2_feature_STLBP_IP_YT','feature_yt');
save('CASME2_feature_STLBP_IP_XT','feature_xt');

feature = [feature_xy;feature_yt;feature_xt];  %512+59+59=630ÿһ����������630ά������
save('CASME2_feature_STLBP_IP','feature');