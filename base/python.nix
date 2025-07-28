{ pkgs }:

let
  commonPackages = ps: with ps; [
    # basics
    ipython
    requests
    beautifulsoup4
    yt-dlp
    build
    twine
    pytest
    editdistance
    multiprocess

    # numerical
    numpy
    scipy
    pandas
    matplotlib
    seaborn
    scikit-learn

    # GPU-enabled PyTorch
    (pytorch.override { cudaSupport = true; })

  ];

  workPackages311 = ps: with ps; [
    lambda-multiprocessing
    tflite-runtime
  ];

  python311 = pkgs.python311.withPackages (ps: commonPackages ps ++ workPackages311 ps);
  python313 = pkgs.python313.withPackages (ps: commonPackages ps);
in
[
  python311
  python313

  # Optional: CUDA runtime libraries (non-Python)
  pkgs.cudaPackages.cudatoolkit
  pkgs.cudaPackages.cudnn
]
