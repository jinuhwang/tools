sudo apt install python3.x
sudo apt-get install python3-distutils python3-widgetsnbextension python3-testresources
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.x get-pip.py
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.x 9
sudo update-alternatives --install /usr/bin/pip pip /home/$USER/.local/bin/pip3.x 9

