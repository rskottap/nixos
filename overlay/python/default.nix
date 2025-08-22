final: prev:
let
  pythonOverlays = python-final: python-prev: {
    lambda-multiprocessing = python-final.callPackage ./lambda-multiprocessing.nix {};
    callable-module = python-final.callPackage ./callable-module.nix {};
    is-instance = python-final.callPackage ./is-instance.nix {};
  };
in
{
  python311 = prev.python311.override {
    packageOverrides = pythonOverlays;
  };
  python313 = prev.python313.override {
    packageOverrides = pythonOverlays;
  };
}
