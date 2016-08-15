cd /d %~dp0
chdir
rem mklink ..\_vimrc .vimrc
copy .vimrc ..\_vimrc
copy _gvimrc ..\
copy .dein.toml ..\_dein.toml
pause
