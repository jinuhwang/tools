git clone https://github.com/unix121/i3wm-themer
cd i3wm-themer/
pip install -r requirements.txt
./install_ubuntu.shupdate-alternatives --install /usr/bin/python python /usr/bin/python2.7 9
python i3wm-themer.py --config config.yaml --load themes/[theme_id].json

