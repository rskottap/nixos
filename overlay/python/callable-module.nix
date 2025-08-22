{
  buildPythonPackage
, fetchFromGitHub
, setuptools
}:

buildPythonPackage {
  pname = "callable-module";
  version = "0.0.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "notarealdeveloper";
    repo = "callable-module";
    rev = "master";
    sha256 = "sha256-jEMTI/XZwe67Ta51F6IafK5U/M2Ixt3Vh4TA5+RZOAA=";
  };

  build-system = [ setuptools ];

}
