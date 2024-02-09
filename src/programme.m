inputs = load('inputs.mat').Inputs1; 
subBytes = load('subBytes.mat').SubBytes;
traces = load('traces1000x512.mat').traces;

traces_size = size(traces, 1);
time_samples_size = size(traces, 2);
keys_size = 256;
P = zeros(traces_size, keys_size);

for k = 0:keys_size-1
    for i = 1:traces_size
        input_byte = uint8(inputs(i)); 
        roundKeyOutput = bitxor(input_byte, uint8(k));
        subByteOutput = subBytes(roundKeyOutput+1); 
        P(i, k+1) = sum(dec2bin(subByteOutput, 8) == '1'); 
    end
end

corr_matrix = zeros(keys_size, time_samples_size);
for k = 1:keys_size
    for t = 1:time_samples_size
        R = corrcoef(P(:, k), traces(:, t));
        corr_matrix(k, t) = R(1, 2);  
    end
end

[~, key_index_max] = max(max(corr_matrix, [], 2));

plot(corr_matrix(key_index_max, :));
title('2D Correlation Plot');
xlabel('Time Sample');
ylabel('Correlation');

surf(corr_matrix);
title('3D Correlation Surface');
xlabel('Time Sample');
ylabel('Key');
zlabel('Correlation');

key_byte = key_index_max - 1;