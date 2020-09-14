function fxy = STLBP_IP_XY(VolData,W)
%% �����Ǽ���ͼ�񼯵������Ϣ��ͨ������LBP_1D�������õ�ͼ��XY���ֱ��ͼ
%  input:
%  VolData ��[height][width][Length] ��ע�⣬����ͼ���[height][width]Ӧ����
%  ͬ�����Ƕ��ڲ�ͬ���в�һ����ͬ
%  W: ������һ��Ϊ3��5��7��9.
%  output:
%  fxy����һ����ֱ��ͼ

%%
fxy = [];
[~,~,Length] = size(VolData);
back_image = VolData(:,:,1);
for i = 2:Length
    now_image = VolData(:,:,i);
    diff_image = imsubtract(now_image,back_image); %�õ����ͼ��
    % horizontal Integral projection ˮƽ����ͶӰ
    h_ip = sum(diff_image,2); %��������Ҫת��
    XVoctor = h_ip';
    Histogram = LBP_1D(XVoctor, W); %ˮƽͶӰ��1DLBP
    h_Histogram = Histogram;
    % vertical Integral projection ��ֱ����ͶӰ
    v_ip = sum(diff_image);
    XVoctor = v_ip;
    Histogram = LBP_1D(XVoctor, W); %��ֱͶӰ��1DLBP
    v_Histogram = Histogram;
    f = [h_Histogram;v_Histogram];
    fxy = [fxy,f];
    fxy = sum(fxy,2)/(Length-1);
end