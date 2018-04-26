prefix=/usr/local

echo "Building Ipopt from ${srcdir}"
echo "Saving headers and libraries to ${prefix}"

# BLAS
cd Ipopt-3.12.7/ThirdParty/Blas
mkdir -p build && cd build
../configure --prefix=$prefix --disable-shared --with-pic
make install

# Lapack
cd ../../Lapack
mkdir -p build && cd build
../configure --prefix=$prefix --disable-shared --with-pic --with-blas="$prefix/lib/libcoinblas.a -lgfortran"
make install

# build everything
cd ../../..
./configure --prefix=$prefix coin_skip_warn_cxxflags=yes --with-blas="$prefix/lib/libcoinblas.a -lgfortran" --with-lapack=$prefix/lib/libcoinlapack.a
make
make test
make -j1 install
