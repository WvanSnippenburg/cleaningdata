Variables contained in dataset:
* observation (integer): the id of the repetition during which the data was collected. Differs from subject in that each subject can do more than one repetition and thus data from a specific sensor can be collected more than once for each person.
* subject (integer): the id of the person performing the action.
* activity (factor): the type of activity during which the measurement was made. Can be: walking, walking_upstairs, walking_downstairs, sitting, standing, laying.
* measurement (factor): the type of measurement. Can be body_acceleration, body_acceleration_jerk, body_gyrometer, body_gyrometer_jerk or gravity_acceleration. See original features_info.txt for detailed description of these measurements.
* mean.x, mean.y, mean.z, std.x, std.y, std.z (floating point numbers): mean value and standard deviation of the measurement in the x, y and z plane.

For further information see the original dataset's README-original.txt and features_info.txt