function average_si = SpeckleIndex(img)
     % ��ȡͼ���С
    [rows, cols] = size(img);

    % ��ʼ�� SI ����
    si_matrix = zeros(rows-2, cols-2);

    % ����ÿ�� 3x3 ���ڵ� SI
    for i = 1:rows-2
        for j = 1:cols-2
            % ��ȡ 3x3 ����
            window = double(img(i:i+2, j:j+2));

           % �����ֵ�ͱ�׼��
            mu = sum(window(:)) / numel(window);
            sigma = std(window(:), 1);

            % ���� SI
            si_matrix(i, j) = sigma / mu;
        end
    end

    % ��������ͼ���ƽ�� SI ֵ
    average_si = sum(si_matrix(:)) / numel(si_matrix);
end