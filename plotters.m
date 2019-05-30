figure;
evenITR=squeeze(solutionSpaceRaw(5,1,:,:));
surf(evenITR); 
zlabel('ITR (bits/trial)')
xlabel('Timeout Threshold (s)');
ylabel('Latency (s)');

% plot class (5/95), failchance=0
figure;
evenITR=squeeze(solutionSpaceRaw(1,1,:,:));
surf(evenITR); 
zlabel('ITR (bits/trial)')
xlabel('Timeout Threshold (s)');
ylabel('Latency (s)');

% plot class (33/66), failchance=0
figure;
evenITR=squeeze(solutionSpaceRaw(4,1,:,:));
surf(evenITR); 
zlabel('ITR (bits/trial)')
xlabel('Timeout Threshold (s)');
ylabel('Latency (s)');

% plot class (50/50), failchance=25
figure;
evenITR=squeeze(solutionSpaceRaw(5,4,:,:));
surf(evenITR); 
zlabel('ITR (bits/trial)')
xlabel('Timeout Threshold (s)');
ylabel('Latency (s)');

% plot class (50/50), failchance=50
figure;
evenITR=squeeze(solutionSpaceRaw(5,5,:,:));
surf(evenITR); 
zlabel('ITR (bits/trial)')
xlabel('Timeout Threshold (s)');
ylabel('Latency (s)');

% plot class (50/50), failchance=75
figure;
evenITR=squeeze(solutionSpaceRaw(5,6,:,:));
surf(evenITR); 
zlabel('ITR (bits/trial)')
xlabel('Timeout Threshold (s)');
ylabel('Latency (s)');
