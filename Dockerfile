FROM debian:testing

RUN apt-get update && apt-get install -y \
  wget \
  git \
  make \
  xzdec \
  texlive-full \
  biber && \
  # Removing documentation packages *after* installing them is kind of hacky,
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y

# install all available packages in their current version via CTAN
RUN tlmgr init-usertree --usermode || true && \
  tlmgr update --self --usermode || true && \
  tlmgr update --all --usermode || true && \
  tlmgr install scheme-full --usermode || true && \
  tlmgr info --usermode || true && \
  updmap -sys || true && \
  updmap -user || true 

# install additional nonfree fonts
RUN wget -q http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts && \
  texlua ./install-getnonfreefonts && \
  getnonfreefonts --sys -a && \

# update fontdb
RUN luaotfload-tool --update
