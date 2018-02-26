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

RUN tlmgr init-usertree && tlmgr update --self && tlmgr update --all&& tlmgr install scheme-full && tlmgr info

# update fontdb
RUN luaotfload-tool --update
