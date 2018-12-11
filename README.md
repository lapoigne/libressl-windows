# libressl-windows

unofficial libressl build for windows

#### This creates a binary version of [libressl](https://www.libressl.org).

* About 1 GB free disk space required to build package

---

Create the package by running `build-libressl-windows.bat`

It create 32-bit version of libressl.

---

You must set OPENSSL_CONF variable before use it

    set OPENSSL_CONF=some\directory\openssl.cnf 
    openssl

---

After that, you can remove CygWin folder.
