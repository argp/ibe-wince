# ibe-wince - a WinCE port of the Stanford IBE library

## Introduction

This is a collection of the files that I modified in order to get the
[Stanford IBE library](http://crypto.stanford.edu/ibe/) version 0.7.2 to
compile on Windows CE.  Please note that this port depends on the
WCECOMPAT library, on the OpenSSL library and on the GMP library.  I have
only tested it on an HP iPAQ H6340 (ARM) running the Windows CE Mobile
2003 operating system.  If you manage to compile it and test it on other
Windows CE platforms, let me know.

## Compilation and installation

In order to compile the Stanford IBE library for Windows CE you need first
to install the [WCECOMPAT library](http://www.essemer.com.au/), the
[OpenSSL library](http://www.openssl.org/), and
[my Windows CE port of the GMP library](https://github.com/argp/gmp-wince).

After you have compiled and installed the above required libraries, copy the
files provided here to the distribution directory of IBE 0.7.2 and overwrite
the existing files there, then simply enter the directory and type nmake.
You probably need to change the include directories in the Makefile, unless
you use the directory structure that I do.  There is no installation required,
just put `byte_string.h`, `curve.h`, `fp2.h` and `ibe_lib.h` to your include
path and `ibe.lib` to your library path.  When you are using it in Embedded
MSVC++ to compile new programs don't forget to define `_NTRG_WINCE_`, include
`ibe_lib.h` and link against all the required libraries.

In the directory `bin/` you can find a pre-compiled (ARM) version.

## Acknowledgements

* Benjamin Lynn, for implementing the Boneh-Franklin identity-based
  encryption scheme.
* Steven Reddie, for the WCECOMPAT library the Windows CE port of OpenSSL.
