function average_si = SpeckleIndex(img)
     % 获取图像大小
    [rows, cols] = size(img);

    % 初始化 SI 矩阵
    si_matrix = zeros(rows-2, cols-2);

    % 计算每个 3x3 窗口的 SI
    for i = 1:rows-2
        for j = 1:cols-2
            % 提取 3x3 窗口
            window = double(img(i:i+2, j:j+2));

           % 计算均值和标准差
            mu = sum(window(:)) / numel(window);
            sigma = std(window(:), 1);

            % 计算 SI
            si_matrix(i, j) = sigma / mu;
        end
    end

    % 计算整个图像的平均 SI 值
    average_si = sum(si_matrix(:)) / numel(si_matrix);
end