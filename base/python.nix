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

    pytorch
    # GPU-enabled PyTorch
    #(pytorch.override { cudaSupport = true; })

    pip
  ];

  workPackages311 = ps: with ps; [
    lambda-multiprocessing
    tflite-runtime
  ];

  python311 = pkgs.python311.withPackages (ps: with ps; workPackages311 ps ++ [pip ipython]);
  python313 = pkgs.python313.withPackages (ps: with ps; commonPackages ps ++ 
      [ 
        is-instance
        #embd
        python-bin
        python-cowsay
        dvc-s3
        #webfs
        imfind
      ]
    );
  python314 = pkgs.python314;
  python315 = pkgs.python315; #.withPackages (ps: with ps; commonPackages ps);
in
[
  python311
  python313
  python314
  python315

  # Optional: CUDA runtime libraries (non-Python)
  #pkgs.cudaPackages.cudatoolkit
  #pkgs.cudaPackages.cudnn
]
