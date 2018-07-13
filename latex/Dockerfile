FROM debian:testing

RUN apt-get update && apt-get install -y \
  wget \
  git \
  make \
  texlive-full \
  biber && \
  wget -q http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts && \
  texlua ./install-getnonfreefonts && \
  getnonfreefonts --sys -a && \
  # Removing documentation packages *after* installing them is kind of hacky,
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y

# update fontdb
RUN luaotfload-tool --update
