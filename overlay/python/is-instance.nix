{
  buildPythonPackage
, fetchFromGitHub
, setuptools
, callable-module
, ...
}:

buildPythonPackage {
  pname = "is-instance";
  version = "0.0.16";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "notarealdeveloper";
    repo = "is-instance";
    rev = "master";
    sha256 = "sha256-VDWjklBXRIXNeV9kHPlJDgx+2tRKySn60yC8cNgTh2Y=";
  };

  build-system = [ setuptools ];

  propagatedBuildInputs = [ callable-module ];
}
