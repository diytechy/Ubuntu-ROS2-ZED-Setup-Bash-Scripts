#Run as "bash InstallZEDExample.sh"
if [ "$(whoami)" == "root" ]; then
        echo "Script must not be run as root"
        exit 255
fi
# Move to the `src` folder of the ROS 2 Workspace
cd ~/ros2_ws/src/
git clone https://github.com/stereolabs/zed-ros2-examples.git
cd ../
source /opt/ros/humble/setup.bash
. ~/ros2_humble/install/local_setup.bash
rosdep install --from-paths src --ignore-src -r -y
colcon build --symlink-install --cmake-args=-DCMAKE_BUILD_TYPE=Release
source ~/.bashrc
