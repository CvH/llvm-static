#!/bin/bash
rm -rf llvm-project-18.1.8.src/
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.8/llvm-project-18.1.8.src.tar.xz
tar xf llvm-project-18.1.8.src.tar.xz
cd llvm-project-18.1.8.src/

PKG_CMAKE_OPTS_COMMON="-DLLVM_INCLUDE_TOOLS=ON \
                       -DLLVM_BUILD_TOOLS=OFF \
                       -DLLVM_BUILD_UTILS=OFF \
                       -DLLVM_BUILD_EXAMPLES=OFF \
                       -DLLVM_INCLUDE_EXAMPLES=OFF \
                       -DLLVM_BUILD_TESTS=OFF \
                       -DLLVM_INCLUDE_TESTS=OFF \
                       -DLLVM_BUILD_BENCHMARKS=OFF \
                       -DLLVM_INCLUDE_BENCHMARKS=OFF \
                       -DLLVM_BUILD_DOCS=OFF \
                       -DLLVM_INCLUDE_DOCS=OFF \
                       -DLLVM_ENABLE_DOXYGEN=OFF \
                       -DLLVM_ENABLE_SPHINX=OFF \
                       -DLLVM_ENABLE_OCAMLDOC=OFF \
                       -DLLVM_ENABLE_BINDINGS=OFF \
                       -DLLVM_ENABLE_TERMINFO=OFF \
                       -DLLVM_ENABLE_ASSERTIONS=OFF \
                       -DLLVM_ENABLE_WERROR=OFF \
                       -DLLVM_ENABLE_ZLIB=OFF \
                       -DLLVM_ENABLE_ZSTD=OFF \
                       -DLLVM_ENABLE_LIBXML2=OFF \
                       -DLLVM_BUILD_LLVM_DYLIB=ON \
                       -DLLVM_LINK_LLVM_DYLIB=ON \
                       -DLLVM_OPTIMIZED_TABLEGEN=ON \
                       -DLLVM_APPEND_VC_REV=OFF \
                       -DLLVM_ENABLE_RTTI=ON \
                       -DLLVM_ENABLE_UNWIND_TABLES=OFF \
                       -DLLVM_ENABLE_Z3_SOLVER=OFF \
                       -DLLVM_SPIRV_INCLUDE_TESTS=OFF \
                       -DCMAKE_SKIP_RPATH=ON"

PKG_BUILD="/home/cvh/llvm-static/llvm-project-18.1.8.src"
HOST_NAME="x86_64"
LLVM_BUILD_TARGETS+="\;X86\;AMDGPU"

#mkdir -p ${PKG_BUILD}/.${HOST_NAME}
#cd ${PKG_BUILD}/.${HOST_NAME}
PKG_CMAKE_OPTS="${PKG_CMAKE_OPTS_COMMON} \
                -DLLVM_ENABLE_PROJECTS='clang' \
                -DCLANG_LINK_CLANG_DYLIB=ON \
                -DLLVM_TARGETS_TO_BUILD=${LLVM_BUILD_TARGETS}"

cmake -S llvm -B build -G Ninja -DCMAKE_BUILD_TYPE=Release ${PKG_CMAKE_OPTS}
cmake --build build
