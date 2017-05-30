## Vim configs
Vim global config with lapis256 color scheme

### Install

Install required packages

#### Debian/Ubuntu
```
apt-get install vim git-core sudo -y
```
#### CentOS/Red Hat
```
yum install vim git-core -y
```
Clone repositary and copy files to `/etc/vim/` directory
```
git clone https://github.com/zloywolk/vim-rc.git
sudo cp -r vim-rc/vim/* /etc/vim/
sudo cp vim-rc/vimrc /etc/vim/vimrc.local
```

### Notes
For lapis256 color scheme need terminal with supporting 256-color palette
