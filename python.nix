{ pkgs }:

let
  python313 = pkgs.python313;
  python311 = pkgs.python311;

in
[
  (python313.withPackages (ps: with ps; [
    requests
    beautifulsoup4

    numpy
    pandas
    scikit-learn
    torch
    transformers

    ipython
    matplotlib
    seaborn
  ]))

  (python311.withPackages (ps: with ps; [
    requests
    beautifulsoup4

    numpy
    pandas
    scikit-learn
    torch
    transformers

    ipython
    matplotlib
    seaborn
  ]))
]
