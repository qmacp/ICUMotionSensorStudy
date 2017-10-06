clear all; close all;
sensorOut = load('../sensorOut.txt');
load('Prelim_Movelet/reach_chapter.mat');
load('Prelim_Movelet/clap_chapter.mat');
load('Prelim_Movelet/wave_chapter.mat');
load('Prelim_Movelet/outstretched_chapter.mat');
distance = [];
distance2 = [];
distance3 = [];
distance4 = [];
distance5 = [];
distance6 = [];
distance7 = [];
distance8 = [];

sensor1 = [];
sensor2 = [];
for i=1:length(sensorOut)
    if (sensorOut(i,1) == 1)
        sensor1 = [sensor1;sensorOut(i,:)];
    end
    if (sensorOut(i,1) == 2)
        sensor2 = [sensor2;sensorOut(i,:)];
    end
end
accel1 = sensor1(:,2:4)';
accel2 = sensor2(:,2:4)';

c_accel1 = [c_accel1_x; c_accel1_y; c_accel1_z;];
c_accel2 = [c_accel2_x; c_accel2_y; c_accel2_z;];
r_accel1 = [r_accel1_x; r_accel1_y; r_accel1_z;];
r_accel2 = [r_accel2_x; r_accel2_y; r_accel2_z;];
o_accel1 = [o_accel1_x; o_accel1_y; o_accel1_z;];
o_accel2 = [o_accel2_x; o_accel2_y; o_accel2_z;];
w_accel1 = [w_accel1_x; w_accel1_y; w_accel1_z;];
w_accel2 = [w_accel2_x; w_accel2_y; w_accel2_z;];


for i = 1:length(accel1)/10
    mvlt = accel1(:,i*10-9:i*10);
    c_distance = [];
    for j = 1:length(c_accel1)-9
        c = c_accel1(:,j:j+9);
        c_distance = [c_distance sum(sqrt(sum((mvlt - c).^2, 2)))/3];
    end
    distance = [distance; min(c_distance)];    
end    
for i = 1:length(accel2)/10
    mvlt = accel2(:,i*10-9:i*10);
    c_distance = [];
    for j = 1:length(c_accel2)-9
        c = c_accel2(:,j:j+9);
        c_distance = [c_distance sum(sqrt(sum((mvlt - c).^2, 2)))/3];
    end
    distance2 = [distance2; min(c_distance)];    
end 
%====================================================================
for i = 1:length(accel1)/10
    mvlt = accel1(:,i*10-9:i*10);
    c_distance = [];
    for j = 1:length(r_accel1)-9
        c = r_accel1(:,j:j+9);
        c_distance = [c_distance sum(sqrt(sum((mvlt - c).^2, 2)))/3];
    end
    distance3 = [distance3; min(c_distance)];    
end    
for i = 1:length(accel2)/10
    mvlt = accel2(:,i*10-9:i*10);
    c_distance = [];
    for j = 1:length(r_accel2)-9
        c = r_accel2(:,j:j+9);
        c_distance = [c_distance sum(sqrt(sum((mvlt - c).^2, 2)))/3];
    end
    distance4 = [distance4; min(c_distance)];    
end 
%========================================================
for i = 1:length(accel1)/10
    mvlt = accel1(:,i*10-9:i*10);
    c_distance = [];
    for j = 1:length(o_accel1)-9
        c = o_accel1(:,j:j+9);
        c_distance = [c_distance sum(sqrt(sum((mvlt - c).^2, 2)))/3];
    end
    distance5 = [distance5; min(c_distance)];    
end    
for i = 1:length(accel2)/10
    mvlt = accel2(:,i*10-9:i*10);
    c_distance = [];
    for j = 1:length(o_accel2)-9
        c = o_accel2(:,j:j+9);
        c_distance = [c_distance sum(sqrt(sum((mvlt - c).^2, 2)))/3];
    end
    distance6 = [distance6; min(c_distance)];    
end 
%=====================================================================
for i = 1:length(accel1)/10
    mvlt = accel1(:,i*10-9:i*10);
    c_distance = [];
    for j = 1:length(w_accel1)-9
        c = w_accel1(:,j:j+9);
        c_distance = [c_distance sum(sqrt(sum((mvlt - c).^2, 2)))/3];
    end
    distance7 = [distance7; min(c_distance)];    
end    
for i = 1:length(accel2)/10
    mvlt = accel2(:,i*10-9:i*10);
    c_distance = [];
    for j = 1:length(w_accel2)-9
        c = w_accel2(:,j:j+9);
        c_distance = [c_distance sum(sqrt(sum((mvlt - c).^2, 2)))/3];
    end
    distance8 = [distance8; min(c_distance)];    
end 
if length(distance) < length(distance2)
distance  = [distance; distance(length(distance))];
distance3 = [distance3; distance3(length(distance3))]; 
distance5 = [distance5; distance5(length(distance5))];
distance7 = [distance7; distance7(length(distance7))] ;
elseif length(distance2) < length(distance)
distance2 = [distance2; distance2(length(distance2))]; 
distance4 = [distance4; distance4(length(distance4))];
distance6 = [distance6; distance6(length(distance6))];
distance8 = [distance8; distance8(length(distance8))]; 
end

clap = (distance+distance2)/2;
reach = (distance3+distance4)/2;
out = (distance5+distance6)/2;
wave = (distance7+distance8)/2;

distance = [clap'; reach'; out'; wave'];
figure(1)
hold on
title('Classification Likeliness')
plot(clap')
plot(reach')
plot(out')
plot(wave')
legend('clap','reach','outstretched','wave')