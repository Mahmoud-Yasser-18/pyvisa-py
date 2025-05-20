{ pkgs, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname = "PyVISA-py";
  # Using a placeholder version since the project uses setuptools_scm
  version = "0.7.0";  # This will be overridden by the actual version from git

  src = ./.;

  nativeBuildInputs = with pythonPackages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with pythonPackages; [
    pyvisa
    typing-extensions
    # Optional dependencies - uncomment as needed
    pyserial        # for serial communication
    pyusb           # for USB communication
    psutil          # for device discovery
    zeroconf        # for HiSLIP discovery and VICP
    # gpib-ctypes   # for GPIB on Windows/Linux
  ];

  checkInputs = with pythonPackages; [
    pytest
  ];

  # Skip tests during build if you don't want to run them
  doCheck = false;

  pythonImportsCheck = [ "pyvisa_py" ];

  meta = with pkgs.lib; {
    description = "Pure Python implementation of a VISA library";
    homepage = "https://github.com/pyvisa/pyvisa-py";
    license = licenses.mit;
    maintainers = with maintainers; [ ];  # Add maintainers if needed
  };
} 