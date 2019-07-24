# Dockerized Pyenv

Docker image with multiple versions of Python managed by Pyenv

## Arguments:
 - `INSTALL_PY_VERSIONS`: delimited string of Pyenv versions to install (_default_: `3.6.8,3.7.2,3.8-dev`)
 - `INSTALL_PY_VERSIONS_SEP`: separator to use for list of versions (_default_: `,`)
 - `PY_BUILD_EXTRAS`: space delimited string of Debian packages required for installation of specified Python versions (_default_: `""`)
 
## License

MIT License
