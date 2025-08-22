final: prev: {
  python311 = prev.python311.override {
    packageOverrides = python-final: python-prev: {
      lambda-multiprocessing = python-final.callPackage ./lambda-multiprocessing.nix {};
    };
  };
  python313 = prev.python313.override {
    packageOverrides = python-final: python-prev: {
      callable-module = python-final.callPackage ./callable-module.nix {};
      is-instance = python-final.callPackage ./is-instance.nix {};
    };
  };

}
