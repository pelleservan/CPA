inputs = load('inputs.mat').Inputs1; 
subBytes = load('subBytes.mat').SubBytes;
traces = load('traces1000x512.mat').traces;

num_traces = size(traces, 1);
num_time_samples = size(traces, 2);
num_keys = 256;
P = zeros(num_traces, num_keys);

for k = 0:num_keys-1
    for i = 1:num_traces
        input_byte = uint8(inputs(i)); 
        roundKeyOutput = bitxor(input_byte, uint8(k));
        subByteOutput = subBytes(roundKeyOutput+1); 
        P(i, k+1) = sum(dec2bin(subByteOutput, 8) == '1'); 
    end
end

correlation_matrix = zeros(num_keys, num_time_samples);
for k = 1:num_keys
    for t = 1:num_time_samples
        R = corrcoef(P(:, k), traces(:, t));
        correlation_matrix(k, t) = R(1, 2);  
    end
end

[~, max_key_index] = max(max(correlation_matrix, [], 2));

plot(correlation_matrix(max_key_index, :));
title('2D Correlation Plot');
xlabel('Time Sample');
ylabel('Correlation');

surf(correlation_matrix);
title('3D Correlation Surface');
xlabel('Time Sample');
ylabel('Key');
zlabel('Correlation');

likely_key_byte = max_key_index - 1;