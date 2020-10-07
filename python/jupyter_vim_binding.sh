# Create required directory in case (optional)
mkdir -p $(python -m jupyter --data-dir)/nbextensions
# Clone the repository
cd $(python -m jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
# Activate the extension
python -m jupyter nbextension enable vim_binding/vim_binding
