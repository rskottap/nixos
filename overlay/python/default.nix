final: prev: {
  python311 = prev.python311.override {
    packageOverrides = python-final: python-prev: {
      lambda-multiprocessing = python-final.callPackage ./lambda-multiprocessing.nix {};
    };
  };
}