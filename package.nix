{
  lib,
  stdenv,
  wlroots,
  cmake,
  pkg-config,
  wayland-scanner,
  libxkbcommon,
  pixman,
  udev,
  wayland,
  wayland-protocols,
}:

stdenv.mkDerivation {
  pname = "graphwl";
  version = "0.1.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./CMakeLists.txt
      ./src
      ./lib
    ];
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    wayland-scanner
  ];
  buildInputs = [
    libxkbcommon
    pixman
    udev
    wayland
    wayland-protocols
    wlroots
  ];

  meta = {
    description = "Wayland compositor based on wlroots, derived from tinywl";
    #license = lib.licenses.;
    inherit (wlroots.meta) platforms;
    mainProgram = "graphwl";
  };
}
