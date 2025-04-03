% Experiment 10: Signal Processing with FIR Filters

% Define parameters
t = 0:1/1000:1;  
f1 = 100; f2 = 120; f3 = 320; % Frequencies in Hz

% Generate multitone signal
x = sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t);

% Sampling frequency
fs = 1000;

% Design FIR filters
lpFilt = designfilt('lowpassfir', 'FilterOrder', 50, 'CutoffFrequency', 250, 'SampleRate', fs);
hpFilt = designfilt('highpassfir', 'FilterOrder', 50, 'CutoffFrequency', 150, 'SampleRate', fs);
bpFilt = designfilt('bandpassfir', 'FilterOrder', 50, 'CutoffFrequency1', 100, 'CutoffFrequency2', 310, 'SampleRate', fs);

% Design a FIR Notch filter at 50 Hz
notchFilt = designfilt('bandstopfir', 'FilterOrder', 50, 'CutoffFrequency1', 49, 'CutoffFrequency2', 51, 'SampleRate', fs);

% Apply filters
y_lp = filter(lpFilt, x);
y_hp = filter(hpFilt, x);
y_bp = filter(bpFilt, x);
y_notch = filter(notchFilt, x);

% Plot results in time domain
figure;
subplot(5,1,1);
plot(t, x); title('Original Signal'); xlabel('Time (s)'); ylabel('Amplitude');

subplot(5,1,2);
plot(t, y_lp); title('Low Pass Filtered'); xlabel('Time (s)'); ylabel('Amplitude');

subplot(5,1,3);
plot(t, y_hp); title('High Pass Filtered'); xlabel('Time (s)'); ylabel('Amplitude');

subplot(5,1,4);
plot(t, y_bp); title('Band Pass Filtered'); xlabel('Time (s)'); ylabel('Amplitude');

subplot(5,1,5);
plot(t, y_notch); title('Notch Filtered (50 Hz Removed)'); xlabel('Time (s)'); ylabel('Amplitude');

% Frequency domain representation
X = abs(fft(x));
Y_lp = abs(fft(y_lp));
Y_hp = abs(fft(y_hp));
Y_bp = abs(fft(y_bp));
Y_notch = abs(fft(y_notch));
f = linspace(0, fs/2, length(X)/2);

figure;
subplot(5,1,1);
plot(f, X(1:end/2)); title('Original Signal Spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(5,1,2);
plot(f, Y_lp(1:end/2)); title('Low Pass Filtered Spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(5,1,3);
plot(f, Y_hp(1:end/2)); title('High Pass Filtered Spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(5,1,4);
plot(f, Y_bp(1:end/2)); title('Band Pass Filtered Spectrum'); xlabel('Frequency (Hz)'); ylabel('Magnitude');

subplot(5,1,5);
plot(f, Y_notch(1:end/2)); title('Notch Filtered Spectrum (50 Hz Removed)'); xlabel('Frequency (Hz)'); ylabel('Magnitude');