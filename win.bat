cd /d %~dp0
chdir
rem mklink ..\_vimrc .vimrc
copy .vimrc ..\_vimrc
copy _gvimrc ..\
pause