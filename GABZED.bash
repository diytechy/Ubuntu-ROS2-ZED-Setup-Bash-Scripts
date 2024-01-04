#Run as "bash GABZED.sh"
if [ "$(whoami)" == "root" ]; then
        echo "Script must not be run as root"
        exit 255
fi
sudo apt install python3-colcon-common-extensions
sudo apt-get install python3-rosdep python3-rosinstall-generator python3-vcstool python3-rosinstall build-essential
# Create your ROS 2 Workspace if you do not have one
#exit 255
mkdir -p ~/ros2_ws/src/
# Move to the `src` folder of the ROS 2 Workspace
cd ~/ros2_ws/src/
source /opt/ros/humble/setup.bash
. ~/ros2_humble/install/local_setup.bash
git clone --recursive https://github.com/stereolabs/zed-ros2-wrapper.git
cd ..
sudo apt update
# Install the required dependencies
rosdep install --from-paths src --ignore-src -r -y # install dependencies
#rosdep update --include-eol-distros  *******
#Run local setup?
#bash ~/ros2_humble/install/local_setup.bash
# Build the wrapper
colcon build --symlink-install --cmake-args=-DCMAKE_BUILD_TYPE=Release --parallel-workers $(nproc) # build the workspace
echo source $(pwd)/install/local_setup.bash >> ~/.bashrc # automatically source the installation in every new bash (optional)
source ~/.bashrc
