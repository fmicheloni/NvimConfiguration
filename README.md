### Install neovim
Nvim can be installed by using Brew (both on OSX and Linux).

```
brew install neovim
```

### Clone repository

```
git config --global url.ssh://git@github.com/.insteadOf https://github.com/
mkdir ~/.config/nvim/ && git clone git@github.com:fmicheloni/NvimConfiguration.git ~/.config/nvim/
```

### Install utilities 
```bash
brew install ripgrep
brew install fzf
brew install myzel394/formulae/config-lsp

# configure autocomplete
$(brew --prefix)/opt/fzf/install

npm install -g yarn # assumes npm is already installed on the machine
```

### Setup Python Environment

Create conda env:
```
conda create -n pynvim python=3.8
conda activate pynvim
```

Install required packages:
```
pip install pynvim
```

