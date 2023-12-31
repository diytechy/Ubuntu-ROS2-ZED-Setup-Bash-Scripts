#Run as "bash GABZED.sh"
if [ "$(whoami)" == "root" ]; then
        echo "Script must not be run as root"
        exit 255
fi
#Source directories.
source /opt/ros/humble/setup.bash
#. ~/ros2_humble/install/local_setup.bash
. ~/ros2_ws/install/local_setup.sh
ros2 launch zed_wrapper zed_camera.launch.py camera_model:=zedm


