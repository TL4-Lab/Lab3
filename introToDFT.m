clear;
close all;
clc;

for i = 0:5
    N = 16*2^i;
    x_n = step(0, N)-step(15,N);
    k = 0:length(x_n)-1;
    DFT_x = DFT(x_n,k,N);
    DFT_x = DFT_x';

    %DFT
    figure();
    subplot(3,1,1);
    plot(abs(DFT_x));
    ylabel("|DFT(x)|");
    xlabel("Frequency(HZ)");
    title(["DFT," "zero padding: " num2str(N)]);

    %DTFT
    w = 2*pi*k/N;
    DTFT_x  = DTFT(x_n,w,N);
    DTFT_x = DTFT_x';
    subplot(3,1,2);
    plot(abs(DTFT_x));
    ylabel("|DTFT(x)|");
    xlabel("Frequency(HZ)");
    title(["DTFT" "zero padding: " num2str(N)]);
    
    %FFT
    subplot(3,1,3);
    plot(abs(fft(x_n)));
    ylabel("|FFT(x)|");
    xlabel("Frequency(HZ)");
    title(["FFT" "zero padding: " num2str(N)]);

end





function output = DFT(x,k,N)
    n = 0:1:N-1;
    output = sum( exp(-1i*2*pi*k'*n/N) .* x,2);
end


function output_dtft = DTFT(x,w,N)
    n = 0:1:N-1;
    output_dtft = sum(exp(-1i*w'*n) .* x,2);
end

function output = step(k, n)
    output = zeros(1,n);
    output(:,k+1:end) = 1;
end