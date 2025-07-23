{ pkgs }:

let
  python = pkgs.python3_13;
in
[
  (python.withPackages (ps: with ps; [
    requests
    beautifulsoup4

    numpy
    pandas
    scikit-learn
    tensorflow
    torch
    transformers

    ipython
    matplotlib
    seaborn
  ]))
]
