BUILD_TYPE=Release
ROOT_DIR=$(pwd)
BUILD_DIR=$ROOT_DIR/build/$BUILD_TYPE
INSTALL_DIR=$$ROOT_DIR/build/install/$BUILD_TYPE

mkdir "$BUILD_DIR"
cd "$BUILD_DIR"

cmake $ROOT_DIR \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR
    
cmake --build . --config $BUILD_TPYE

cmake --build . --target install --config $BUILD_TYPE
