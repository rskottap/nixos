final: prev:
let
  pythonOverlays = python-final: python-prev: {
    imfind = python-final.callPackage ./imfind.nix {};
  };
in
{
  # Removed python311 from overlay to avoid tkinter issues
  python313 = prev.python313.override {
    packageOverrides = pythonOverlays;
  };
}
