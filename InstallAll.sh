if [ "$(whoami)" == "root" ]; then
        echo "Script must not be run as root"
        exit 255
fi

read -t 1 -p "****************************************"$'\n'
read -t 1 -p "Upgrading ubuntu..."$'\n'
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe"
sudo apt-get update
sudo apt-get upgrade

read -t 1 -p "****************************************"$'\n'
read -t 1 -p "Checking local..."$'\n'

locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings

read -t 1 -p "****************************************"$'\n'
read -t 1 -p "Adding ROS2 apt repository..."$'\n'
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

read -t 1 -p "****************************************"$'\n'
read -t 1 -p "Installing developement tools"$'\n'
sudo apt update && sudo apt install -y \
  python3-flake8-docstrings \
  python3-pip \
  python3-pytest-cov \
  ros-dev-tools
  
 sudo apt install -y \
   python3-flake8-blind-except \
   python3-flake8-builtins \
   python3-flake8-class-newline \
   python3-flake8-comprehensions \
   python3-flake8-deprecated \
   python3-flake8-import-order \
   python3-flake8-quotes \
   python3-pytest-repeat \
   python3-pytest-rerunfailures


read -t 1 -p "****************************************"$'\n'
read -t 1 -p "Getting ROS2 code..."$'\n'
mkdir -p ~/ros2_humble/src
cd ~/ros2_humble
vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src


read -t 1 -p "****************************************"$'\n'
read -t 1 -p "Getting ROS2 dependencies..."$'\n'
sudo apt upgrade
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers"

read -t 1 -p "****************************************"$'\n'
read -t 1 -p "Installing build dependencies..."$'\n'
sudo apt install python3-colcon-common-extensions


read -t 1 -p "****************************************"$'\n'
read -t 1 -p "Creating ROS2 Workspace and building..."$'\n'
mkdir -p ~/ros2_humble/
cd ~/ros2_humble/
colcon build --symlink-install
