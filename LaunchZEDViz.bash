#Run as "bash LaunchZEDViz.sh"
if [ "$(whoami)" == "root" ]; then
        echo "Script must not be run as root"
        exit 255
fi
#Source directories.
source /opt/ros/humble/setup.bash
. ~/ros2_humble/install/local_setup.bash
. ~/ros2_ws/install/local_setup.sh
ros2 launch zed_display_rviz2 display_zed_cam.launch.py camera_model:=zedm
