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

% Process data
% One row per time stamp

tiledlayout(3,4);

% Activity: Standing still

% Accelerometer data
nexttile;
plot(stillData(:,1), stillData(:,2:4));
legend("acc_x", "acc_y", "acc_z")
xlabel("Timestamp [us]")
ylabel("Acceleration [m^2/s]")
title("Still: Accelerometer data")

% Gyroscope data
nexttile;
plot(stillData(:,1), stillData(:,5:7));
legend("gyr_x", "gyr_y", "gyr_z")
xlabel("Timestamp [us]")
ylabel("")
title("Still: Gyroscope data")

% Magnetometer data
nexttile;
plot(stillData(:,1), stillData(:,8:10));
legend("mag_x", "mag_y", "mag_z")
xlabel("Timestamp [us]")
ylabel("")
title("Still: Magnetometer data")

% GPS data
nexttile;
plot(stillData(:,1), stillData(:,11:13));
legend("gps_x", "gps_y", "gps_z")
xlabel("Timestamp [us]")
ylabel("Position")
title("Still: GPS data")

% Activity: Walking

% Accelerometer data
nexttile;
plot(walkData(:,1), walkData(:,2:4));
legend("acc_x", "acc_y", "acc_z")
xlabel("Timestamp [us]")
ylabel("Acceleration [m^2/s]")
title("Walk: Accelerometer data")

% Gyroscope data
nexttile;
plot(walkData(:,1), walkData(:,5:7));
legend("gyr_x", "gyr_y", "gyr_z")
xlabel("Timestamp [us]")
ylabel("")
title("Walk: Gyroscope data")

% Magnetometer data
nexttile;
plot(walkData(:,1), walkData(:,8:10));
legend("mag_x", "mag_y", "mag_z")
xlabel("Timestamp [us]")
ylabel("")
title("Walk: Magnetometer data")

% GPS data
nexttile;
plot(walkData(:,1), walkData(:,11:13));
legend("gps_x", "gps_y", "gps_z")
xlabel("Timestamp [us]")
ylabel("Position")
title("Walk: GPS data")

% Activity: Running

% Accelerometer data
nexttile;
plot(runData(:,1), runData(:,2:4));
legend("acc_x", "acc_y", "acc_z")
xlabel("Timestamp [us]")
ylabel("Acceleration [m^2/s]")
title("Run: Accelerometer data")

% Gyroscope data
nexttile;
plot(runData(:,1), runData(:,5:7));
legend("gyr_x", "gyr_y", "gyr_z")
xlabel("Timestamp [us]")
ylabel("")
title("Run: Gyroscope data")

% Magnetometer data
nexttile;
plot(runData(:,1), runData(:,8:10));
legend("mag_x", "mag_y", "mag_z")
xlabel("Timestamp [us]")
ylabel("")
title("Run: Magnetometer data")

% GPS data
nexttile;
plot(runData(:,1), runData(:,11:13));
legend("gps_x", "gps_y", "gps_z")
xlabel("Timestamp [us]")
ylabel("Position")
title("Run: GPS data")