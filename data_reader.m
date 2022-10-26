%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loaded data description:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% data(1)         Time [ms]
% data(1, 2:4)    Accelerometer; x, y, z [m/s^2]
% data(1, 5:7)    Gyroscope; x, y, z [rad/s]
% data(1, 8:10)   Magnetometer; x, y, z [uT]
% data(1, 11:13)  GPS [deg North, deg East, alt m]
% data(1, 14)     Pressure [hPa]
% data(1, 15)     Light [lux]
% data(1, 16)     Proximity [cm]
% data(1, 17)     Temperature [deg C]
% data(1, 18:21)  Orientation [normalized quaternion]
% data(1, 22:27)  Uncalibrated gyroscope; x, y, z, bx, by, bz [rad/s]
% data(1, 28:33)  Uncalibrated magnetometer; x, y, z, bx, by, bz [uT]
%
% Nan values indicate missing data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read sensor data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

import se.hendeby.sensordata.*;

stillDataFile = FileSensorDataReader("./data/sensorLog_20221024T182616_standstill.txt");
walkDataFile = FileSensorDataReader("./data/sensorLog_20221024T182709_walking_pocket.txt");
%walkDataFile = FileSensorDataReader("./data/sensorLog_20221024T182635_walking_hand.txt");
runDataFile = FileSensorDataReader("./data/sensorLog_20221024T182818_running_pocket.txt");
%runDataFile = FileSensorDataReader("./data/sensorLog_20221024T182741_running_hand.txt");
%runDataFile = FileSensorDataReader("./data/sensorLog_20221024T183036_walking_pocket_long_time.txt");

stillDataFile.start();
walkDataFile.start();
runDataFile.start();

% Normal measurement data
stillDataFile.reset();
walkDataFile.reset();
runDataFile.reset();

% Typically group things separated less than half a period
stillData = stillDataFile.getAll(5);
walkData = walkDataFile.getAll(5);
runData = runDataFile.getAll(5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot sensor data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
tiledlayout(3,4);

% Activity: Standing still

% Accelerometer data
nexttile;
plot(stillData(:,1), stillData(:,2:4), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Acceleration [m/s^2]")
title("Standing: Accelerometer data")

% Gyroscope data
nexttile;
plot(stillData(:,1), stillData(:,5:7), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Angular velocity [rad/s]")
title("Standing: Gyroscope data")

% Magnetometer data
nexttile;
plot(stillData(:,1), stillData(:,8:10), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Magnetic field strength [uT]")
title("Standing: Magnetometer data")

% GPS data
nexttile;
plot(stillData(:,1), stillData(:,11:13), '.');
grid on;
legend("deg North", "deg East", "Alt m")
xlabel("Timestamp [ms]")
ylabel("Position [deg North, deg East, alt m]")
title("Standing: GPS data")

% Activity: Walking

% Accelerometer data
nexttile;
plot(walkData(:,1), walkData(:,2:4), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Acceleration [m/s^2]")
title("Walking: Accelerometer data")

% Gyroscope data
nexttile;
plot(walkData(:,1), walkData(:,5:7), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Angular velocity [rad/s]")
title("Walking: Gyroscope data")

% Magnetometer data
nexttile;
plot(walkData(:,1), walkData(:,8:10), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Magnetic field strength [uT]")
title("Walking: Magnetometer data")

% GPS data
nexttile;
plot(walkData(:,1), walkData(:,11:13), '.');
grid on;
legend("deg North", "deg East", "Alt m")
xlabel("Timestamp [ms]")
ylabel("Position [deg North, deg East, alt m]")
title("Walking: GPS data")

% Activity: Running

% Accelerometer data
nexttile;
plot(runData(:,1), runData(:,2:4), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Acceleration [m/s^2]")
title("Running: Accelerometer data")

% Gyroscope data
nexttile;
plot(runData(:,1), runData(:,5:7), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Angular velocity [rad/s]")
title("Running: Gyroscope data")

% Magnetometer data
nexttile;
plot(runData(:,1), runData(:,8:10), '.');
grid on;
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Magnetic field strength [uT]")
title("Running: Magnetometer data")

% GPS data
nexttile;
plot(runData(:,1), runData(:,11:13), '.');
grid on;
legend("deg North", "deg East", "Alt m")
xlabel("Timestamp [ms]")
ylabel("Position [deg North, deg East, alt m]")
title("Running: GPS data")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate 2-norm of 3D vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classes = ["still", "walk", "run"];

stillSize = size(stillData);
walkSize = size(walkData);
runSize = size(runData);

maxLength = max([stillSize(1), walkSize(1), runSize(1)]);
totalLenght = stillSize(1) + walkSize(1) + runSize(1);

% A single vector for all 1. still, 2. walk and 3. run data
acc = nan(maxLength, 3); 
gyr = nan(maxLength, 3);
mag = nan(maxLength, 3);
gps = nan(maxLength, 3);

for n = 1:maxLength
    % Still
    if n <= stillSize(1)
        acc(n, 1) = norm(stillData(n, 2:4));
        gyr(n, 1) = norm(stillData(n, 5:7));
        mag(n, 1) = norm(stillData(n, 8:10));
        gps(n, 1) = norm(stillData(n, 11:13));
    end
    % Walk
    if n <= walkSize(1)
        acc(n, 2) = norm(walkData(n, 2:4));
        gyr(n, 2) = norm(walkData(n, 5:7));
        mag(n, 2) = norm(walkData(n, 8:10));
        gps(n, 2) = norm(walkData(n, 11:13));
    end
    % Run
    if n <= runSize(1)
        acc(n, 3) = norm(runData(n, 2:4));
        gyr(n, 3) = norm(runData(n, 5:7));
        mag(n, 3) = norm(runData(n, 8:10));
        gps(n, 3) = norm(runData(n, 11:13));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate data boxplots (stats)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
tiledlayout(1,4);

nexttile;
boxplot(acc, classes);
grid on;
xlabel("Activity")
ylabel("2-norm(Acceleration Force)")
title("Accelerometer data")

nexttile;
boxplot(gyr, classes);
grid on;
xlabel("Activity")
ylabel("2-norm(Angular Velocity)")
title("Gyroscope data")

nexttile;
boxplot(mag, classes);
grid on;
xlabel("Activity")
ylabel("2-norm(Magnetic Force)")
title("Magnetometer data")

nexttile;
boxplot(gps, classes);
grid on;
xlabel("Activity")
ylabel("2-norm(Position)")
title("GPS data")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate violin plots (with estimated PDF)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
tiledlayout(1,4);

nexttile;
violin(acc, 'xlabel', classes);
grid on;
xlabel("Activity")
ylabel("2-norm(Acceleration Force)")
title("Accelerometer data")

nexttile;
violin(gyr, 'xlabel', classes);
grid on;
xlabel("Activity")
ylabel("2-norm(Angular Velocity)")
title("Gyroscope data")

nexttile;
violin(mag, 'xlabel', classes);
grid on;
xlabel("Activity")
ylabel("2-norm(Magnetic Force)")
title("Magnetometer data")

nexttile;
violin(gps, 'xlabel', classes);
grid on;
xlabel("Activity")
ylabel("2-norm(Position)")
title("GPS data")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data preparation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO: Removing outliers

% Merging data from all three activities
mergedData = [stillData; walkData; runData];
classesVector = strings(totalLenght, 1);

for k = (1:totalLenght)
    if k <= stillSize(1)
        classesVector(k, 1) = "still";
    end
    if (k > stillSize(1)) && (k <= stillSize(1)+walkSize(1))
        classesVector(k, 1) = "walk";
    end
    if (k > stillSize(1)+walkSize(1)) && (k <= stillSize(1)+walkSize(1)+runSize(1))
        classesVector(k, 1) = "run";
    end
end