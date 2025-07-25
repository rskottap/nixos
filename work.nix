{ pkgs }:

let
  disableChecks = pkg: pkg.overrideAttrs (_: { doCheck = false; });

  python = pkgs.python311.override {
    packageOverrides = self: super: {
      numpy = super.numpy_1;

      pandas = disableChecks super.pandas;
      lightgbm = disableChecks super.lightgbm;

      scikit-learn = disableChecks (
        super.buildPythonPackage rec {
          pname = "scikit-learn";
          version = "1.4.2";

          src = pkgs.fetchPypi {
            inherit pname version;
            sha256 = "sha256-2qHEcdlbrQgMbkS0lGyTkKSEKtwwglcsIOT4iE456Vk=";
          };

          propagatedBuildInputs = with super; [
            numpy
            scipy
            joblib
            threadpoolctl
          ];

          meta = super.scikit-learn.meta // {
            description = "Machine learning in Python";
          };
        }
      );
    };
  };
in
[
  (python.withPackages (ps: with ps; [
    numpy
    pandas
    scikit-learn
    lightgbm
  ]))
]
