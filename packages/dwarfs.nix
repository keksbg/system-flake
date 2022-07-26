{ stdenv
, bison
, boost
, cmake
, double-conversion
, fetchFromGitHub
, fmt_8
, fuse3
, gflags
, git
, glog
, gtest
, jemalloc
, lib
, libarchive
, libevent
, libunwind
, lz4
, openssl
, pkg-config
, ronn
, xxHash
, xz
, zstd
}:

stdenv.mkDerivation rec {
  pname = "dwarfs";
  version = "0.6.1";
  src = fetchFromGitHub {
    owner = "mhx";
    repo = "dwarfs";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-bGJkgcq8JxueRTX08QpJv1A0O5wXbiIgUY7BrY0Ln/M=";
  };

  # Needs tagged git repo for generating some files
  # leaveDotGit alone isn't enough and breaks reproducible hashing
  preConfigure = ''
    git init
    git add .
    git -c user.name=root -c user.email=root@localhost commit -m "v${version}" -q
    git -c user.name=root -c user.email=root@localhost tag "v${version}" -m "v${version}"
  '';

  # ...but the files are still kinda ugly, so let's make the
  # data prettier for wherever it gets used ;)
  postConfigure = ''
    sed -i \
      -e 's/\(PRJ_GIT_REV = \).*/\1"${src.rev}";/' \
      -e 's/\(PRJ_GIT_DESC = \).*/\1"${version}";/' \
      -e 's/\(PRJ_GIT_BRANCH = \).*/\1"${src.rev}";/' \
      -e 's/\(PRJ_GIT_ID = \).*/\1"v${version}";/' \
      ../src/dwarfs/version.cpp
  '';

  cmakeFlags = [
    "-DPREFER_SYSTEM_ZSTD=ON"
    "-DPREFER_SYSTEM_XXHASH=ON"
    "-DPREFER_SYSTEM_GTEST=ON"

    "-DWITH_LEGACY_FUSE=ON"
    "-DWITH_TESTS=ON"
  ];

  nativeBuildInputs = [
    bison
    cmake
    git
    pkg-config
    ronn
  ];

  buildInputs = [
    # dwarfs
    boost
    fmt_8
    fuse3
    libarchive
    lz4
    xxHash
    xz
    zstd

    # folly (fsr not all dependencies?)
    double-conversion
    gflags
    glog
    jemalloc
    libevent
    libunwind
    openssl
  ];

  doCheck = true;
  checkInputs = [ gtest ];
  # this fails inside of the sandbox due to missing access
  # to the FUSE device
  GTEST_FILTER = "-tools.everything";

  meta = with lib; {
    description = "A fast high compression read-only file system";
    homepage = "https://github.com/mhx/dwarfs";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.keksbg ];
    platforms = platforms.linux;
  };

}
