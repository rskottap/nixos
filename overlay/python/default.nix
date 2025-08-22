final: prev:
let
  pythonOverlays = python-final: python-prev: {
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
