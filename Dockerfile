FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHON python python-pip python-scipy python-matplotlib python-scipy python-pil
ENV LATEX texlive texlive-latex-extra dvipng texlive-luatex texlive-xetex \
          texlive-lang-english texlive-lang-french

RUN apt-get update && \
    apt-get install $PYTHON && \
    apt-get install $LATEX  && \
    apt-get install git && \
    # install pandoc
      cd /tmp && \
      apt-get install libgmp10 && \
      apt-get install curl && \
      curl -L https://github.com/jgm/pandoc/releases/download/1.16.0.2/pandoc-1.16.0.2-1-amd64.deb > pandoc.deb && \
    # install pandoc-templates
      cd /tmp && \
      git clone https://github.com/boisgera/pandoc-templates.git && \
      cd pandoc-templates && \
      ./install.sh && \
    # install eul-doc
      cd /tmp && \
      git clone https://github.com/boisgera/eul-doc.git && \
      cd eul-doc && \
      pip install --target=.lib --ignore-installed 'about>=5.1,<6' && \
      pip install . && \
    # install npm and node
      apt-get install curl && \
      curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - && \ 
      apt-get install nodejs && \
    # install eul-style
      cd /tmp && \
      git clone https://github.com/boisgera/eul-style.git && \
      cd eul-style && \
      npm install -g coffee-script && \
      ./install && \
    # clean-up and exit
      rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get autoremove && \
      true

