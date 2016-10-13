set -ue

brew install autoconf automake gcc gsl arpack
autoconf
aclocal
automake --add-missing
./configure CXX=g++-6 LDFLAGS="-L/usr/local/Cellar/gsl/2.2.1/lib" CFLAGS="-stdlib=libstdc++ -I/usr/local/Cellar/gsl/2.2.1/include"
make
