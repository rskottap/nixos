{
  buildPythonPackage
, fetchFromGitHub
, setuptools
, pytest
, twine
, requests
, torch
, transformers
, easyocr
, pillow
, pillow-heif
, assure
, mmry
, embd
, ...
}:

buildPythonPackage {
  pname = "imfind";
  version = "0.0.10";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rskottap";
    repo = "imfind";
    rev = "master";
    sha256 = "sha256-AolwU3//GYKdq3LT9/sAOVbum90WTALfpXNNmzKK3DA=";
  };

  build-system = [ setuptools ];

  propagatedBuildInputs = [
    pytest
    twine
    requests
    torch
    transformers
    easyocr
    pillow
    pillow-heif
    assure
    mmry
    embd
   ];
}
