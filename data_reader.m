import se.hendeby.sensordata.*;

stillDataFile = FileSensorDataReader("./data/sensorLog_20221024T182616_standstill.txt");
walkDataFile = FileSensorDataReader("./data/sensorLog_20221024T182709_walking_pocket.txt");
runDataFile = FileSensorDataReader("./data/sensorLog_20221024T182818_running_pocket.txt");

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

% Loaded data description:
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


% Process data
% One row per time stamp

tiledlayout(3,4);

% Activity: Standing still

% Accelerometer data
nexttile;
plot(stillData(:,1), stillData(:,2:4));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Acceleration [m/s^2]")
title("Standing: Accelerometer data")

% Gyroscope data
nexttile;
plot(stillData(:,1), stillData(:,5:7));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Angular velocity [rad/s]")
title("Standing: Gyroscope data")

% Magnetometer data
nexttile;
plot(stillData(:,1), stillData(:,8:10));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Magnetic field strength [uT]")
title("Standing: Magnetometer data")

% GPS data
nexttile;
plot(stillData(:,1), stillData(:,11:13));
legend("deg North", "deg East", "Alt m")
xlabel("Timestamp [ms]")
ylabel("Position [deg North, deg East, alt m]")
title("Standing: GPS data")

% Activity: Walking

% Accelerometer data
nexttile;
plot(walkData(:,1), walkData(:,2:4));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Acceleration [m/s^2]")
title("Walking: Accelerometer data")

% Gyroscope data
nexttile;
plot(walkData(:,1), walkData(:,5:7));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Angular velocity [rad/s]")
title("Walking: Gyroscope data")

% Magnetometer data
nexttile;
plot(walkData(:,1), walkData(:,8:10));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Magnetic field strength [uT]")
title("Walking: Magnetometer data")

% GPS data
nexttile;
plot(walkData(:,1), walkData(:,11:13));
legend("deg North", "deg East", "Alt m")
xlabel("Timestamp [ms]")
ylabel("Position [deg North, deg East, alt m]")
title("Walking: GPS data")

% Activity: Running

% Accelerometer data
nexttile;
plot(runData(:,1), runData(:,2:4));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Acceleration [m/s^2]")
title("Running: Accelerometer data")

% Gyroscope data
nexttile;
plot(runData(:,1), runData(:,5:7));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Angular velocity [rad/s]")
title("Running: Gyroscope data")

% Magnetometer data
nexttile;
plot(runData(:,1), runData(:,8:10));
legend("x", "y", "z")
xlabel("Timestamp [ms]")
ylabel("Magnetic field strength [uT]")
title("Running: Magnetometer data")

% GPS data
nexttile;
plot(runData(:,1), runData(:,11:13));
legend("deg North", "deg East", "Alt m")
xlabel("Timestamp [ms]")
ylabel("Position [deg North, deg East, alt m]")
title("Running: GPS data")