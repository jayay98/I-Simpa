export DEBIAN_FRONTEND=noninteractive


export CXX="g++-4.8"
export CC="gcc-4.8"

if [ -d $HOME/boost-install/include ] ; then
	echo "Boost already builded (and in travis cache)"
else
	cd
	wget https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.bz2
	tar -xjf boost_1_61_0.tar.bz2
	mkdir $HOME/boost-install
	echo "using gcc : 4.8 : gcc-4.8 ;" > ~/user-config.jam
	cd  $HOME/boost_1_61_0 && ./bootstrap.sh link=static variant=release address-model=64 cxxflags="-std=c++11 -fPIC" boost.locale.icu=off --with-libraries=filesystem,system,test,regex,python,random,thread --prefix=$HOME/boost-install && ./b2 install
fi



if [ -d $HOME/wxWidgets-install/include ] ; then
	echo "wxWidget already builded (and in travis cache)"
else
	cd
	wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.0/wxWidgets-3.1.0.tar.bz2
	tar -xjf wxWidgets-3.1.0.tar.bz2
	mkdir $HOME/wxWidgets-install
	cd $HOME/wxWidgets-3.1.0 && ./configure --prefix=$HOME/wxWidgets-install --disable-shared && make && make install
fi

# check wxWidget install
export PATH=$HOME/wxWidgets-install/bin/:$PATH
echo "wxWidget version : "
wx-config --version

