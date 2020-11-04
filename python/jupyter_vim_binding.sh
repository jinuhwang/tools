# Create required directory in case (optional)
python -m pip install jupyter_contrib_nbextensions
python -m jupyter nbextensions_configurator enable --user

# You may need the following to create the directoy
mkdir -p $(python -m jupyter --data-dir)/nbextensions
# Now clone the repository
cd $(python -m jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
chmod -R go-w vim_binding
