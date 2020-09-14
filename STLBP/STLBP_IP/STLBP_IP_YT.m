function fyt = STLBP_IP_YT(VolData)
%% �����ǽ����������ͼ�񼯵õ����ͼ��ˮƽ����ͶӰ���õ��˶�����ͼƬ
%   ����lbp�õ��õ������ֱ��ͼ�����ת��Ϊ������
%   input:
%   VolData ��[height][width][Length] ��ע�⣬����ͼ���[height][width]Ӧ����
%   ͬ�����Ƕ��ڲ�ͬ���в�һ����ͬ
%   output:
%   fyt:��һ����ֱ��ͼ��������

%% �õ����ͼ���ˮƽ����ͶӰ������ͼimage_yt
image_yt = [];
[~,~,Length] = size(VolData);
back_image = VolData(:,:,1);
for i = 2:Length
    now_image = VolData(:,:,i);
    diff_image = imsubtract(now_image,back_image); %�õ����ͼ��
    % horizontal Integral projection ˮƽ����ͶӰ
    h_ip = sum(diff_image,2); %�õ�һ�Ų��ͼ���ˮƽ����ͶӰ������������
    image_yt = [image_yt,h_ip] %���յõ��˶�ˮƽ����ͶӰ������ͼ
end

%%  �õ�image_yt��lbp����������һ����ת�õõ�������
mapping=getmapping(8,'u2'); 
fyt = lbp(image_yt,1,8,mapping,'h');
fyt = fyt/sum(fyt,2);  %����������һ��
fyt = fyt';