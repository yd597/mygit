function fxt = STLBP_IP_XT(VolData)
%% �����ǽ����������ͼ�񼯵õ����ͼ�񣬴�ֱ����ͶӰ���õ��˶�����ͼƬ
%   ����lbp�õ��õ������ֱ��ͼ�����ת��Ϊ������
%   input:
%   VolData ��[height][width][Length] ��ע�⣬����ͼ���[height][width]Ӧ����
%   ͬ�����Ƕ��ڲ�ͬ���в�һ����ͬ
%   output:
%   fxt:��һ����ֱ��ͼ��������

%% �õ����ͼ��Ĵ�ֱ����ͶӰ������ͼimage_xt
image_xt = [];
[~,~,Length] = size(VolData);
back_image = VolData(:,:,1);
for i = 2:Length
    now_image = VolData(:,:,i);
    diff_image = imsubtract(now_image,back_image); %�õ����ͼ��
    % horizontal Integral projection ��ֱ����ͶӰ
    h_ip = sum(diff_image); %�õ�һ�Ų��ͼ��Ĵ�ֱ����ͶӰ������������
    image_xt = [image_xt;h_ip] %���յõ��˶�ˮƽ����ͶӰ������ͼ
end

%%  �õ�image_xt��lbp����������һ����ת�õõ�������
mapping=getmapping(8,'u2'); 
fxt = lbp(image_xt,1,8,mapping,'h');
fxt = fxt/sum(fxt,2);  %����������һ��
fxt = fxt'