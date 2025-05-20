{
  description = "Pure Python implementation of a VISA library";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python311;
        pythonPackages = python.pkgs;
        
        pyvisa-py = import ./derivation.nix {
          inherit pkgs pythonPackages;
        };
      in
      {
        packages = {
          default = pyvisa-py;
          pyvisa-py = pyvisa-py;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python
            pythonPackages.pip
            pythonPackages.pyvisa
            pythonPackages.pyserial
            pythonPackages.pyusb
            pythonPackages.psutil
            pythonPackages.zeroconf
            pythonPackages.setuptools
            pythonPackages.wheel
            pythonPackages.setuptools-scm
            # Development dependencies
            pythonPackages.ruff
            pythonPackages.pytest
            pythonPackages.sphinx
            pythonPackages.sphinx-rtd-theme
            # Optional: For testing GPIB if needed
            # pythonPackages.gpib-ctypes
          ];
          
          shellHook = ''
            export PYTHONPATH=$PWD:$PYTHONPATH
            echo Hello to pyvisa
          '';
        };
      }
    );
} 
