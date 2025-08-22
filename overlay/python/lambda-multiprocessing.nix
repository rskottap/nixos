{
  buildPythonPackage
, fetchFromGitHub
, setuptools
, ...
}:

buildPythonPackage rec {
  pname = "lambda-multiprocessing";
  version = "1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mdavis-xyz";
    repo = "lambda_multiprocessing";
    rev = "master";
    sha256 = "sha256-pWk15b7xVWVJD4psFU7Rfy8t6uSDZKt5o9VCDSKjwqQ=";
  };

  build-system = [ setuptools ];

  propagatedBuildInputs = [
    setuptools
  ];
}
